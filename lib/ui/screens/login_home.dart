import 'dart:async';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:nexthour/common/apipath.dart';
import 'package:nexthour/common/route_paths.dart';
import 'package:nexthour/my_app.dart';
import 'package:nexthour/providers/app_config.dart';
import 'package:nexthour/ui/shared/logo.dart';
import 'package:provider/provider.dart';
import 'bottom_navigations_bar.dart';
import 'package:nexthour/classes/language.dart';
import 'package:nexthour/localization/language_constants.dart';
// import 'package:nexthour/router/route_constants.dart';
import 'package:nexthour/generated/l10n.dart';
import 'package:nexthour/main.dart';

DateTime currentBackPressTime;

class LoginHome extends StatefulWidget {
  @override
  _LoginHomeState createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  bool _visible = false;
  bool isLoggedIn = false;
  var profileData;
  // var facebookLogin = FacebookLogin();


  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }

  Widget welcomeTitle() {
    return Consumer<AppConfig>(builder: (context, myModel, child) {
      return myModel != null
          ? Text(
        S.of(context).welcomeText + ' ' + "${myModel.appModel.config.title}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: "AvenirNext",
                  color: Color.fromRGBO(125, 183, 91, 1.0)),
            )
          : Text("");
    });
  }

//  Register button
  Widget registerButton() {
    return ListTile(
        title: MaterialButton(
            height: 50.0,
            color: Colors.white,
            textColor: Colors.black,
            child: new Text(S.of(context).registerWelcomeText),
            onPressed: () =>
                Navigator.pushNamed(context, RoutePaths.register)));
  }
  //  Register button
  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    // MyApp.setLocale(context, _locale);
    MyApp.setLocale(context, _locale);
  }
  Widget changeLanguage() {
    return ListTile(
        title:   Align(
          alignment: Alignment.center,
          child: DropdownButton<Language>(
            underline: SizedBox(),
            hint: Text(S.of(context).formFieldChangeLanguage,
              style: TextStyle(color: Colors.grey),
            ),
            // icon: Icon(
            //   Icons.language,
            //   color: Colors.white,
            // ),
            onChanged: (Language language) {
              _changeLanguage(language);
            },
            items: Language.languageList()
                .map<DropdownMenuItem<Language>>(
                  (e) => DropdownMenuItem<Language>(
                value: e,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      e.flag,
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(e.name)
                  ],
                ),
              ),
            )
                .toList(),
          ),
        ));
  }

//  Setting background design of login button
  Widget loginButton() {
    return MaterialButton(
        height: 50.0,
        textColor: Colors.white,
        child: new Text(S.of(context).loginWelcomeText),
        onPressed: () => Navigator.pushNamed(context, RoutePaths.login));
  }

  Widget loginListTile() {
    return ListTile(
        title: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Color.fromRGBO(72, 163, 198, 0.4).withOpacity(0.4),
            Color.fromRGBO(72, 163, 198, 0.3).withOpacity(0.5),
            Color.fromRGBO(72, 163, 198, 0.2).withOpacity(0.6),
            Color.fromRGBO(72, 163, 198, 0.1).withOpacity(0.7),
          ],
        ),
      ),
      child: loginButton(),
    ));
  }

// If you get HTML tag in copy right text
  Widget html() {
    return Consumer<AppConfig>(builder: (context, myModel, child) {
      return HtmlWidget("${myModel.appModel.config.copyright}",
      );
      // return Html(
      //   data: myModel == null ? "" : "${myModel.appModel.config.copyright}",
      //   style: {
      //     "p": Style(alignment: Alignment.center),
      //   },
      // );
    });
  }

// Copyright text
  Widget copyRightTextContainer(myModel) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: new Align(
          alignment: FractionalOffset.bottomCenter,
          heightFactor: 100,
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
//    For setting copyright text on the login page
                  myModel == null
                      ? SizedBox.shrink()
                      :
                  // Text("${myModel.config.copyright}"),
// If you get HTML tag in copy right text
                 html(),
                ],
              )
            ],
          )),
    );
  }

// Background image filter
  Widget imageBackDropFilter() {
    return BackdropFilter(
      filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
      child: new Container(
        decoration: new BoxDecoration(color: Colors.black.withOpacity(0.0)),
      ),
    );
  }

// ListView contains buttons and logo
  Widget listView(myModel) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 100.0,
        ),
        AnimatedOpacity(

/*
  If the widget is visible, animate to 0.0 (invisible).
  If the widget is hidden, animate to 1.0 (fully visible).
*/
          opacity: _visible == true ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),

/*
For setting logo image that is accessed from the server using API.
You can change logo by server
*/
          child: logoImage(context, myModel, 0.9, 100.0, 250.0),
        ),
        SizedBox(
          height: 20.0,
        ),
/*
  For setting title on the Login or registration page that is accessed from the server using API.
  You can change this title by server
*/
        welcomeTitle(),
        SizedBox(
          height: 5.0,
        ),
        Text(S.of(context).signWelcomeText,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(
          height: 50.0,
        ),
        loginListTile(),
        SizedBox(
          height: 5.0,
        ),
        registerButton(),
        SizedBox(
          height: 5.0,
        ),
        changeLanguage()
      ],
    );
  }

//Overall this page in Stack
  Widget stack(myModel) {
    final logo = Provider.of<AppConfig>(context, listen: false).appModel;
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
//   For setting background color of loading screen.

            color: Theme.of(context).primaryColorLight,
            image: new DecorationImage(
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.dstATop),
/*
  For setting logo image that is accessed from the server using API.
  You can change logo by server
*/
              image: NetworkImage(
                '${APIData.loginImageUri}${logo.loginImg.image}',
              ),
            ),
          ),
          child: imageBackDropFilter(),
        ),
        listView(myModel),
        copyRightTextContainer(myModel),
      ],
    );
  }

// WillPopScope to handle app exit
  Widget willPopScope(myModel) {
    return WillPopScope(
        child: Container(
            child: Center(
          child: stack(myModel),
        )),
        onWillPop: onWillPopS);
  }

  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      setState(() {
        _visible = true;
      });
    });
  }

// build method
  @override
  Widget build(BuildContext context) {
    final myModel = Provider.of<AppConfig>(context).appModel;
    return Scaffold(
      body: myModel == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : willPopScope(myModel),
    );
  }
}
