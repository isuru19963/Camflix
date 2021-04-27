import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:nexthour/common/apipath.dart';
import 'package:nexthour/common/route_paths.dart';
import 'package:nexthour/common/global.dart';
import 'package:nexthour/providers/app_config.dart';
import 'package:nexthour/providers/main_data_provider.dart';
import 'package:nexthour/providers/menu_provider.dart';
import 'package:nexthour/providers/movie_tv_provider.dart';
import 'package:nexthour/providers/slider_provider.dart';
import 'package:nexthour/providers/user_profile_provider.dart';
import 'package:nexthour/ui/screens/multi_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  SplashScreen({this.token});
  final String token;
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  bool _flexibleUpdateAvailable = false;
  AppUpdateInfo _updateInfo;
  // ignore: unused_field
  String _debugLabelString = "";
  bool circular=false;
  AnimationController animationController;
  Animation<double> animation;
  // ignore: unused_field
  bool _enableConsentButton = false;
  bool _requireConsent = true;

  Future<Null> setLocalPath() async {
    setState(() {
      localPath = APIData.localPath;
    });
  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) => _showError(e));
    if(_updateInfo.updateAvailable){
      InAppUpdate.startFlexibleUpdate().then((_) {
        setState(() {
          _flexibleUpdateAvailable = true;
        });
      }).catchError((e) => _showError(e));
    }
    if(!_flexibleUpdateAvailable){
      InAppUpdate.completeFlexibleUpdate().then((_) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Success!')));
      }).catchError((e) => _showError(e));
    }
  }

  void _showError(dynamic exception) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(exception.toString())));
  }

  // For One Signal notification
  Future<void> initPlatformState() async {
    if (!mounted) return;

    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setRequiresUserPrivacyConsent(_requireConsent);

    var settings = {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.promptBeforeOpeningPushUrl: true
    };

    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      this.setState(() {
        _debugLabelString =
        "Received notification: \n${notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      this.setState(() {
        _debugLabelString =
        "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared
        .setInAppMessageClickedHandler((OSInAppMessageAction action) {
      this.setState(() {
        _debugLabelString =
        "In App Message Clicked: \n${action.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {});

    OneSignal.shared
        .setPermissionObserver((OSPermissionStateChanges changes) {});

    OneSignal.shared.setEmailSubscriptionObserver(
            (OSEmailSubscriptionStateChanges changes) {});

    await OneSignal.shared.init(APIData.onSignalAppId, iOSSettings: settings);

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    bool requiresConsent = await OneSignal.shared.requiresUserPrivacyConsent();

    this.setState(() {
      _enableConsentButton = requiresConsent;
    });
    oneSignalInAppMessagingTriggerExamples();
  }

  oneSignalInAppMessagingTriggerExamples() async {
    OneSignal.shared.addTrigger("trigger_1", "one");

    Map<String, Object> triggers = new Map<String, Object>();
    triggers["trigger_2"] = "two";
    triggers["trigger_3"] = "three";
    OneSignal.shared.addTriggers(triggers);

    OneSignal.shared.removeTriggerForKey("trigger_2");

    // ignore: unused_local_variable
    Object triggerValue =
    await OneSignal.shared.getTriggerValueForKey("trigger_3");
    List<String> keys = new List<String>();
    keys.add("trigger_1");
    keys.add("trigger_3");
    OneSignal.shared.removeTriggersForKeys(keys);

    OneSignal.shared.pauseInAppMessages(false);
  }

  // For One Signal permission
  void _handleConsent() {
    OneSignal.shared.consentGranted(true);
    this.setState(() {
      _enableConsentButton = false;
    });
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 1));
    animation =
    new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();
    Timer timer = Timer(Duration(seconds: 2), () {
      setState(() {
        circular = true;
      });
    });
//   In app update and it works only in live mode after deploying on PlayStore
//    checkForUpdate();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setLocalPath();
        checkLoginStatus();
      });

  }


  Widget logoImage(myModel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Image.asset('assets/logo.png',
            width: 350.0,
            height: 250.0,
          ),
        )
      ],
    );
  }

  Future checkLoginStatus() async {
    final appConfig = Provider.of<AppConfig>(context, listen: false);
    await appConfig.getHomeData(context);
    final all = await storage.read(key: "login");
    if (all == "true") {
      _handleConsent();
      initPlatformState();
      var token = await storage.read(key: "authToken");
      setState(() {
        authToken = token;
      });
      final menuProvider = Provider.of<MenuProvider>(context, listen: false);
      final userProfileProvider = Provider.of<UserProfileProvider>(
          context, listen: false);
      final mainProvider = Provider.of<MainProvider>(context, listen: false);
      final sliderProvider = Provider.of<SliderProvider>(
          context, listen: false);
      final movieTVProvider = Provider.of<MovieTVProvider>(context, listen: false);
      await userProfileProvider.getUserProfile(context);
      await menuProvider.getMenus(context);
      await sliderProvider.getSlider();
      await mainProvider.getMainApiData(context);
      await movieTVProvider.getMoviesTVData(context);
        var userDetails = Provider.of<UserProfileProvider>(context, listen: false);
        if(userDetails.userProfileModel.active == "1" ||
            userDetails.userProfileModel.active == 1){
          if(userDetails.userProfileModel.payment == "Free"){
            Navigator.pushNamed(context, RoutePaths.bottomNavigationHome);
          }else{
            var activeScreen = await storage.read(key: "activeScreen");
            var actScreenCount = await storage.read(key: "screenCount");
            if(activeScreen == null){
              Navigator.pushNamed(context, RoutePaths.multiScreen);
            }
            else{
              setState(() {
                myActiveScreen = activeScreen;
                screenCount = actScreenCount;
              });
              getAllScreens();
              Navigator.pushNamed(context, RoutePaths.bottomNavigationHome);
            }
          }
        }else{
          Navigator.pushNamed(context, RoutePaths.bottomNavigationHome);
        }
    } else {
      if(appConfig.slides.length == 0){
        Navigator.pushNamed(context, RoutePaths.loginHome);
      }else{
        Navigator.pushNamed(context, RoutePaths.introSlider);
      }
    }
  }

  Future<String> getAllScreens() async {
    final getAllScreensResponse = await http.get(Uri.encodeFull(APIData.showScreensApi), headers: {
      HttpHeaders.authorizationHeader: "Bearer $authToken",
      "Accept" : "application/json"
    });
    if(getAllScreensResponse.statusCode == 200){
      var screensRes = json.decode(getAllScreensResponse.body);
      setState(() {
        screen1 = screensRes['screen']['screen1'] == null ? "Screen1" : screensRes['screen']['screen1'];
        screen2 = screensRes['screen']['screen2'] == null ? "Screen2" : screensRes['screen']['screen2'];
        screen3 = screensRes['screen']['screen3'] == null ? "Screen3" : screensRes['screen']['screen3'];
        screen4 = screensRes['screen']['screen4'] == null ? "Screen4" : screensRes['screen']['screen4'];

        activeScreen = screensRes['screen']['activescreen'];
        screenUsed1 = screensRes['screen']['screen_1_used'];
        screenUsed2 = screensRes['screen']['screen_2_used'];
        screenUsed3 = screensRes['screen']['screen_3_used'];
        screenUsed4 = screensRes['screen']['screen_4_used'];
        screenList = [
          ScreenProfile(0, screen1, screenUsed1),
          ScreenProfile(1, screen2, screenUsed2),
          ScreenProfile(2, screen3, screenUsed3),
          ScreenProfile(3, screen4, screenUsed4),
        ];
      });

    }else if(getAllScreensResponse.statusCode == 401){
      storage.deleteAll();
      Navigator.pushNamed(context, RoutePaths.login);
    }
    else{
      throw "Can't get screens data";
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    final myModel = Provider.of<AppConfig>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body:
      Stack(

        fit: StackFit.expand,
        children: <Widget>[
          new Column(

            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Padding(
              //   padding: EdgeInsets.only(bottom: 30.0),
              //   // child: new Image.asset(
              //   //   'assets/images/powered_by.png',
              //   //   height: 25.0,
              //   //   fit: BoxFit.scaleDown,
              //   // )),
              //   child:new Text('Developed by www.gitl.lk', style: TextStyle(
              //       fontSize: 16,
              //       fontWeight: FontWeight.w700,
              //       color: Colors.black
              //   )),)
            ],
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                'assets/logo.png',
                width: animation.value * 250,
                height: animation.value * 250,
              ),
              circular? new Image.asset(
                'assets/splashgif.gif',
              ):Container()
            ],
          ),

        ],
      ),
      // Stack(
      //   children: [
      //     // Image.asset("assets/placeholder_box.png",
      //     //   fit: BoxFit.cover,
      //     //   height: double.infinity,
      //     // ),
      //     // Container(
      //     //   decoration: BoxDecoration(
      //     //     color: Theme.of(context).primaryColorLight.withOpacity(0.8),
      //     //   ),
      //     // ),
      //     Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         logoImage(myModel),
      //         CircularProgressIndicator(backgroundColor: Colors.black,),
      //       ],
      //     ),
      //   ],
      // )
    );
  }
}
