// import 'package:flutter/material.dart';
// import 'package:toast/toast.dart';
// import 'package:nexthour/ui/gateways/CinetPay/cinet_pay_screen.dart';
// import 'package:uuid/uuid.dart';
// import 'package:uuid/uuid_util.dart';
// import 'dart:math';
// class CinetPayHome extends StatefulWidget {
//   CinetPayHome({Key key, this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<CinetPayHome> {
//   bool _loading = true;
//   TextEditingController amountController = new TextEditingController();
//
//   Future<void> _goToPay(double amount) async {
//
//
//     // Generate a v1 (time-based) id
//     Random random = new Random();
//     int randomNumber = random.nextInt(100);
//     String apiKey = "1406566872606db484a63cc1.74603974";
//     int siteId = 130522;
//     String notifyUrl = "http://173.82.212.70/cinetpay/success";
//     String currency = "XOF";
//     String designation = "Camflix";
//
//     String transId = randomNumber.toString(); // Mettre en place un endpoint pour générer un ID de transaction unique dans votre base de données
//     String custom = randomNumber.toString();
//
//     Navigator.push(context, MaterialPageRoute(builder: (context)=> CinetPaymentScreen(apiKey, siteId, notifyUrl, amount, transId, currency, designation, custom)));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         centerTitle: true,
//       ),
//       body: Center(
//           child: Stack(
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     "Exaaemple d'intégration du SDK JavaScript.",
//                     style: TextStyle(
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 50.0),
//                   Text(
//                     "Constitution du panier.",
//                     style: Theme.of(context).textTheme.headline4,
//                   ),
//                   SizedBox(height: 50.0),
//                   new Container(
//                     padding: EdgeInsets.symmetric(horizontal: 20.0),
//                     margin: EdgeInsets.symmetric(horizontal: 50.0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12.0),
//                       border: Border.all(color: Theme.of(context).primaryColor),
//                     ),
//                     child: new TextField(
//                       controller: amountController,
//                       decoration: InputDecoration(
//                         hintText: "Montant",
//                         border: InputBorder.none,
//                       ),
//                       keyboardType: TextInputType.number,
//                     ),
//                   ),
//                   SizedBox(height: 40.0),
//                   new Container(
//                     width: 200,
//                     height: 50,
//                     decoration: new BoxDecoration(
//                       boxShadow: [
//                         new BoxShadow(
//                           color: Color.fromARGB(38, 31, 84, 195),
//                           offset: Offset(0.0, 6.0),
//                           blurRadius: 20.0,
//                         ),
//                       ],
//                     ),
//                     child: new RaisedButton(
//                       onPressed: () async {
//                         String amount = amountController.text;
//
//                         if(amount.isEmpty){
//                           Toast.show("Le montant est obligatoire", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
//                           return;
//                         }
//
//                         amountController.clear();
//
//                         Navigator.of(context).pop();
//
//                         if (mounted) {
//                           setState(() {
//                             _loading = false;
//                           });
//                         }
//                         return await _goToPay(double.parse(amount));
//                       },
//                       color: Colors.green,
//                       shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//                       child: new Text("Payer", style: new TextStyle(color: Colors.white, fontSize: 20.0)),
//                     ),
//                   ),
//                 ],
//               ),
//               Offstage(
//                 offstage: _loading,
//                 child: progressWidget(),
//               ),
//             ],
//           )
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
//
//   Widget progressWidget(){
//     return new Stack(
//       children: [
//         Container(
//           color: Colors.white,
//         ),
//         Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               CircularProgressIndicator(),
//               SizedBox(height: MediaQuery.of(context).size.width * 0.05),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Text("Veuillez patienter, initialisation du paiement", textAlign: TextAlign.center),
//               ),
//             ],
//           ),
//         )
//       ],
//     ) ;
//   }
// }
