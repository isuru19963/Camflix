import 'dart:core';
import 'package:flutter/material.dart';
import 'package:nexthour/ui/gateways/paypal/paypal_screen.dart';
import 'package:nexthour/ui/shared/appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:nexthour/ui/gateways/CinetPay/cinet_pay_screen.dart';
import 'package:toast/toast.dart';
import 'dart:math';

class CinetPayment extends StatefulWidget {
  final Function onFinish;
  final String currency;
  final String userFirstName;
  final String userLastName;
  final String userEmail;
  final String payAmount;
  final planIndex;

  CinetPayment({this.onFinish, this.currency, this.userFirstName, this.userLastName, this.userEmail, this.payAmount, this.planIndex});

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<CinetPayment> {
  String dropdownValue = "XOF";
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loading = true;
  TextEditingController amountController = new TextEditingController();
  Future<void> _goToPay(double amount) async {
    String apiKey = "1406566872606db484a63cc1.74603974";
    int siteId = 130522;
    String notifyUrl = "http://173.82.212.70/cinetpay/success";
    String currency = dropdownValue;
    String designation = "Exemple SDK JavaScript CinetPay";
    Random random = new Random();
    int randomNumber = random.nextInt(100);
    // String transId = randomNumber.toString(); // Mettre en place un endpoint pour générer un ID de transaction unique dans votre base de données
    String transId = randomNumber.toString(); // Me
    String custom = randomNumber.toString();

    Navigator.push(context, MaterialPageRoute(builder: (context)=> CinetPaymentScreen(apiKey, siteId, notifyUrl, amount, transId, currency, designation, custom,widget.planIndex)));
  }
  // Future<void> _goToPay(double amount) async {
  //   String apiKey = "12912847765bc0db748fdd44.40081707";
  //   int siteId = 445160;
  //   String notifyUrl = "YOUR_NOTIFY_URL";
  //   String currency = "XAF";
  //   String designation = "Exemple SDK JavaScript CinetPay";
  //
  //   String transId = "CGYFFT8Y8J9U0"; // Mettre en place un endpoint pour générer un ID de transaction unique dans votre base de données
  //   String custom = "CGYFFT8Y8J9U0";
  //
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=> CinetPaymentScreen(apiKey, siteId, notifyUrl, amount, transId, currency, designation, custom)));
  // }
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      amountController.text = widget.payAmount;
    });
   // _goToPay(double.parse(widget.payAmount));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cinet Pay'),
        centerTitle: true,
      ),
      body: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(50.0),
                    child: Image.asset("assets/logo.png", scale: 1.0, width: 150.0,),
                  ),
                  Text(
                    "You have to pay "+dropdownValue.toString()+" "+widget.payAmount+" for Subscribe our plan",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(padding: EdgeInsets.all(50.0),
                    child: Image.asset("assets/cinetpay.png", scale: 1.0, width: 150.0,),
                  ),

                  Row(
                    children: [
                      Expanded(
                        flex:4,child: Text(
                        "Select Currency",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),),
                      Expanded(flex:6,child:new Container(
                        // padding: EdgeInsets.symmetric(horizontal: 20.0),
                        margin: EdgeInsets.symmetric(horizontal: 50.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: Theme.of(context).primaryColor),
                        ),
                        child: new DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.white),
                          underline: Container(
                            height: 2,
                            color: Colors.teal,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>['XOF', 'XAF']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,style: TextStyle(fontSize: 20),),
                            );
                          }).toList(),
                        ),
                      ),)
                    ],
                  ),
                  Row(children: [
                    SizedBox(height: 20,)
                  ],),

                  new Container(
                    width: 200,
                    height: 50,
                    decoration: new BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                          color: Color.fromARGB(38, 31, 84, 195),
                          offset: Offset(0.0, 6.0),
                          blurRadius: 20.0,
                        ),
                      ],
                    ),
                    child: new RaisedButton(
                      onPressed: () async {
                        String amount = widget.payAmount;

                        if(amount.isEmpty){
                          Toast.show("Le montant est obligatoire", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
                          return;
                        }

                        amountController.clear();

                        Navigator.of(context).pop();

                        if (mounted) {
                          setState(() {
                            _loading = false;
                          });
                        }
                        return await _goToPay(double.parse(amount));
                      },
                      color: Colors.green,
                      shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      child: new Text("Pay by Cinetpay", style: new TextStyle(color: Colors.white, fontSize: 20.0)),
                    ),
                  ),
                ],
              ),
              Offstage(
                offstage: _loading,
                child: progressWidget(),
              ),
            ],
          )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget progressWidget(){
    return new Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: MediaQuery.of(context).size.width * 0.05),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text("Veuillez patienter, initialisation du paiement", textAlign: TextAlign.center),
              ),
            ],
          ),
        )
      ],
    ) ;
  }
}
