import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:nexthour/common/apipath.dart';
import 'package:nexthour/common/global.dart';
import 'package:nexthour/common/route_paths.dart';
import 'package:nexthour/ui/screens/app_subscribe_success.dart';
import 'package:nexthour/ui/screens/home_screen.dart';
import 'package:nexthour/ui/screens/splash_screen.dart';
import 'package:nexthour/ui/shared/appbar.dart';
import 'package:nexthour/ui/shared/success_ticket.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:nexthour/ui/gateways/CinetPay/cinet_pay.dart';

class CinetPaymentScreen extends StatefulWidget {
  String apiKey;
  int siteId;
  String notificationUrl;
  double amount;
  String transactionId;
  String currency;
  String designation;
  String cpmCustom;
  final planIndex;

  CinetPaymentScreen(
      this.apiKey,
      this.siteId,
      this.notificationUrl,
      this.amount,
      this.transactionId,
      this.currency,
      this.designation,
      this.cpmCustom,
      this.planIndex
      );

  @override
  CinetPaymentScreenState createState() => CinetPaymentScreenState();
}

class CinetPaymentScreenState extends State<CinetPaymentScreen> {
  bool isDataAvailable = true;
  bool isShowing = true;
  bool isBack = false;
  var createdDate;
  var createdTime;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: InAppWebView(
            initialFile: "assets/cinetpay.html",
            initialHeaders: {},
            initialOptions: new InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                useShouldOverrideUrlLoading: true,
                useOnLoadResource: true,
              ),
            ),
            onWebViewCreated: (InAppWebViewController controller) {

              controller.addJavaScriptHandler(
                  handlerName: 'elementToSend',
                  callback: (args) {
                    return {
                      'api_key': "${widget.apiKey}",
                      'site_id': "${widget.siteId}",
                      'notification_url': "${widget.notificationUrl}",
                      'amount': "${widget.amount}",
                      'transaction_id': "${widget.transactionId}",
                      'currency': "${widget.currency}",
                      'designation': "${widget.designation}",
                      'cpmCustom': "${widget.cpmCustom}"
                    };
                  });

              controller.addJavaScriptHandler(
                  handlerName: 'success',
                  callback: (args) async {
                    // Mettre en place un endpoint pour vérifier le statut du paiement
                    // dans votre base de données après le retour et faire les traitement appropriés
                    await _sendDetails(widget.transactionId,widget.planIndex);
                    _onAlertWithStylePressed(context, "Succès","Votre paiement a été approuvé avec succès.",'success');
                  //  return showDialog(barrierDismissible: false, context: context, builder: (context) => AlertDialog(contextIn: context, icon: Icons.check, color: Colors.lightGreenAccent, title: "Succès", description: "Votre paiement a été approuvé avec succès."));
                   // return showDialog(barrierDismissible: false, context: context, builder: (context) => AlertDialog(contextIn: context, icon: Icons.clear, color: Colors.redAccent, title: "Echec", description: "Votre paiement a echoué."));
                  });

              controller.addJavaScriptHandler(
                  handlerName: 'error',
                  callback: (args) {
                    _onAlertWithStylePressed(context,  args[0],args[1],'error');
                   // return showDialog(barrierDismissible: false, context: context, builder: (context) => AlertDialog(contextIn: context, icon: Icons.clear, color: Colors.redAccent, title: args[0], description: args[1]));
                  });
            },
            onLoadStart: (InAppWebViewController controller, String url) {
            },
            onProgressChanged:
                (InAppWebViewController controller, int progress) {},
            onConsoleMessage:
                (InAppWebViewController controller, ConsoleMessage message) {
              print("ConsoleMessage ${message.message}");
            },

          ),
        ),
      ),
    );
  }
  goToDialog(purDate, time, msgRes) {
    setState(() {
      isDataAvailable = true;
    });
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => new GestureDetector(
          child: Container(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SuccessTicket(
                  msgResponse: "$msgRes",
                  planAmount: widget.amount.toString(),
                  subDate: purDate,
                  time: time,
                ),
                SizedBox(
                  height: 10.0,
                ),
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, RoutePaths.splashScreen, arguments: SplashScreen(token: authToken,));
                  },
                )
              ],
            ),
          ),
        ));
  }
  //  Send payment details
  _sendDetails(transactionId, planId) async {
    try {
      final sendResponse = await http.post(APIData.sendRazorDetails, body: {
        "reference": "$transactionId",
        "amount": "${widget.amount}",
        "plan_id": "$planId",
        "status": "1",
        "method": "CinetPay",
      }, headers: {
        HttpHeaders.authorizationHeader: "Bearer $authToken",
        "Accept" : "application/json"
      }
      );
      var response = json.decode(sendResponse.body);
      if(sendResponse.statusCode == 200){
        var msgResponse = response['message'];
        var subRes = response['subscription'];
        var date  = subRes['created_at'];
        var time = subRes['created_at'];
        createdDate = DateFormat('d MMM y').format(DateTime.parse(date));
        createdTime = DateFormat('HH:mm a').format(DateTime.parse(time));
        setState(() {
          isShowing = false;
        });
        goToDialog(createdDate, createdTime, msgResponse);
      } else {
        setState(() {
          isShowing = false;
        });
        Fluttertoast.showToast(msg: "Your transaction failed.");
      }
    } catch (error) {
      print(error);
    }
  }
  _onAlertWithStylePressed(context,title,description,alertType) {
    // Reusable alert style
    var alertStyle = AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        descStyle: TextStyle(fontWeight: FontWeight.bold),
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle: TextStyle(
          color: alertType=='error'?Colors.red:Colors.green,
        ),
        constraints: BoxConstraints.expand(width: 300),
        //First to chars "55" represents transparency of color
        overlayColor: Color(0x55000000),
        alertElevation: 0,
        alertAlignment: Alignment.center);

    // Alert dialog using custom alert style
    Alert(
      context: context,
      style: alertStyle,
      type: alertType=='error'?AlertType.error:AlertType.success,
      title: title.toString(),
      desc: description.toString(),
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            alertType!='error'?
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SplashScreen()),
                  (Route<dynamic> route) => false,
            ):
             Navigator.pop(context);
            // Navigator.pop(context);
    },
    color:
     Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }

}

// class AlertDialog extends StatelessWidget {
//   final String title, description;
//   final IconData icon;
//   final Color color;
//   final BuildContext contextIn;
//
//   AlertDialog({@required this.contextIn, @required this.icon, @required this.color, @required this.title, @required this.description});
//   var alertStyle = AlertStyle(
//       animationType: AnimationType.fromBottom,
//       isCloseButton: true,
//       isOverlayTapDismiss: false,
//       descStyle: TextStyle(fontWeight: FontWeight.bold),
//       animationDuration: Duration(milliseconds: 400),
//       alertBorder: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(0.0),
//         side: BorderSide(
//           color: Colors.grey,
//         ),
//       ),
//       titleStyle: TextStyle(
//         color: Colors.red,
//       ),
//       constraints: BoxConstraints.expand(width: 300),
//       //First to chars "55" represents transparency of color
//       overlayColor: Color(0x55000000),
//       alertElevation: 0,
//       alertAlignment: Alignment.bottomRight);
//   @override
//   Widget build(BuildContext context) {
//
//  Alert(
//         context: context,
//         style: alertStyle,
//         type: AlertType.error,
//         title: "RFLUTTER ALERT",
//         desc: "Flutter is more awesome with RFlutter Alert.",
//         buttons: [
//           DialogButton(
//             child: Text(
//               "COOL",
//               style: TextStyle(color: Colors.white, fontSize: 20),
//             ),
//             onPressed: () => Navigator.pop(context),
//             color: Color.fromRGBO(0, 179, 134, 1.0),
//             radius: BorderRadius.circular(0.0),
//           ),
//         ],
//       ).show();
//
//
//     // return Dialog(
//     //   shape: RoundedRectangleBorder(
//     //     borderRadius: BorderRadius.circular(16),
//     //   ),
//     //   elevation: 0,
//     //   backgroundColor: Colors.transparent,
//     //   child: dialogContent(context),
//     // );
//
//
//     // Alert dialog using custom alert style
//
//   }
//
//   dialogContent(context) {
//     var alertStyle = AlertStyle(
//         animationType: AnimationType.fromTop,
//         isCloseButton: false,
//         isOverlayTapDismiss: false,
//         descStyle: TextStyle(fontWeight: FontWeight.bold),
//         animationDuration: Duration(milliseconds: 400),
//         alertBorder: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(0.0),
//           side: BorderSide(
//             color: Colors.grey,
//           ),
//         ),
//         titleStyle: TextStyle(
//           color: Colors.red,
//         ),
//         constraints: BoxConstraints.expand(width: 300),
//         //First to chars "55" represents transparency of color
//         overlayColor: Color(0x55000000),
//         alertElevation: 0,
//         alertAlignment: Alignment.topCenter);
//      Alert(
//       context: context,
//       style: alertStyle,
//       type: AlertType.info,
//       title: "RFLUTTER ALERT",
//       desc: "Flutter is more awesome with RFlutter Alert.",
//       buttons: [
//         DialogButton(
//           child: Text(
//             "COOL",
//             style: TextStyle(color: Colors.white, fontSize: 20),
//           ),
//           onPressed: () => Navigator.pop(context),
//           color: Color.fromRGBO(0, 179, 134, 1.0),
//           radius: BorderRadius.circular(0.0),
//         ),
//       ],
//     ).show();
//   }
// }