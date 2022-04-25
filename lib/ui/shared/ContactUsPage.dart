import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<ContactUsPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _appbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        BackButton(color: Colors.black),
        // IconButton(
        //     icon: Icon(
        //       model.isfavourite ? Icons.favorite : Icons.favorite_border,
        //       color: model.isfavourite ? Colors.red : LightColor.grey,
        //     ),
        //     onPressed: () {
        //       setState(() {
        //         model.isfavourite = !model.isfavourite;
        //       });
        //     })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TextStyle titleStyle = TextStyles.title.copyWith(fontSize: 25).bold;
    // if (AppTheme.fullWidth(context) < 393) {
    //   titleStyle = TextStyles.title.copyWith(fontSize: 23).bold;
    // }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Image.asset("assets/getintouch.png"),
            DraggableScrollableSheet(
              maxChildSize: .8,
              initialChildSize: .68,
              minChildSize: .4,
              builder: (context, scrollController) {
                return Container(
                  // height: AppTheme.fullHeight(context) * .1,
                  padding: EdgeInsets.only(
                      left: 19,
                      right: 19,
                      top: 16), //symmetric(horizontal: 19, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Colors.indigoAccent,
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('Contact Us',
                                  style: TextStyle(fontSize: 25.0)),
                              SizedBox(
                                width: 10,
                              ),
                              // Icon(Icons.check_circle,
                              //     size: 18,
                              //     color: Theme.of(context).primaryColor),
                              // RatingStar(
                              //   rating: model.fee,
                              // )
                            ],
                          ),
                          // subtitle: Text(
                          //   widget.category,
                          //   style: TextStyles.bodySm.subTitleColor.bold,
                          // ),
                        ),

                        Divider(
                          thickness: .3,
                          color: Colors.grey,
                        ),
                        // Text(widget.title, style: titleStyle).vP16,
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          elevation: 10,
                          child: Ink(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 3),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.lightBlueAccent.shade100
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.location_on,
                                      size: 30, color: Colors.purple),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Our Address',
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Address',
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              // subtitle: Text(
                              //   widget.category,
                              //   style: TextStyles.bodySm.subTitleColor.bold,
                              // ),
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          elevation: 10,
                          child: Ink(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 3),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.lightBlueAccent.shade100
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.email,
                                      size: 30, color: Colors.purple),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Email Us',
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'add@gmail.com',
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              // subtitle: Text(
                              //   widget.category,
                              //   style: TextStyles.bodySm.subTitleColor.bold,
                              // ),
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          elevation: 10,
                          child: Ink(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 3),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.lightBlueAccent.shade100
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.location_on,
                                      size: 30, color: Colors.purple),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Call Us',
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '+934433433',
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              // subtitle: Text(
                              //   widget.category,
                              //   style: TextStyles.bodySm.subTitleColor.bold,
                              // ),
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          elevation: 10,
                          child: Ink(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 3),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.lightBlueAccent.shade100
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: GestureDetector(
                              onTap: () {
                                openwhatsapp();
                                // Fluttertoast.showToast(msg: "clicked");
                              },
                              child: ListTile(
                                contentPadding: EdgeInsets.all(0),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    FaIcon(FontAwesomeIcons.whatsapp,
                                        size: 30, color: Colors.purple),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'WhatsApp',
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '+934433433',
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                                // subtitle: Text(
                                //   widget.category,
                                //   style: TextStyles.bodySm.subTitleColor.bold,
                                // ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            _appbar(),
          ],
        ),
      ),
    );
  }
}

openwhatsapp() async {
  var whatsapp = "+14435295014";
  var whatsappURl_android = "whatsapp://send?phone=" + whatsapp;
  var whatappURL_ios = "https://wa.me/$whatsapp?}";
  if (Platform.isIOS) {
    // for iOS phone only
    if (await canLaunch(whatappURL_ios)) {
      await launch(whatappURL_ios, forceSafariVC: false);
    }
  } else {
    // android , web
    if (await canLaunch(whatsappURl_android)) {
      await launch(whatsappURl_android);
    }
  }
}
