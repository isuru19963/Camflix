import 'package:flutter/material.dart';
import 'package:nexthour/ui/shared/ContactUsPage.dart';
import 'package:share/share.dart';

// Share tab
class ContactUs extends StatelessWidget {
  ContactUs(this.shareType, this.shareId);
  final shareType;
  final shareId;

  Widget shareText(){
    return Text(
      "Contact Us",
      style: TextStyle(
          fontFamily: 'Lato',
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.0,
          color: Colors.white
        // color: Colors.white
      ),
    );
  }

  Widget shareTabColumn(){
    return Column(
      mainAxisAlignment:
      MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.phone,
          size: 30.0,
          color: Colors.white,
        ),
        new Padding(
          padding:
          const EdgeInsets.fromLTRB(
              0.0, 0.0, 0.0, 10.0),
        ),
        shareText(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Material(
          child:  new InkWell(
            onTap: () {
              // Share.share('$shareType'+'$shareId');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    ContactUsPage()),
              );
            },
            child: shareTabColumn(),
          ),
          color: Colors.transparent,
        )
    );
  }
}