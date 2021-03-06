import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nexthour/generated/l10n.dart';
class BlankWishList extends StatefulWidget {
  @override
  _BlankWishListState createState() => _BlankWishListState();
}

class _BlankWishListState extends State<BlankWishList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.solidCheckCircle,
              size: 150,
              color: Theme.of(context).cardColor.withOpacity(0.5),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Text(S.of(context).wishlist1text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white.withOpacity(0.55),
                  ),
                ),),
            ],
          ),
        ),
        SizedBox(
          height: 40.0,
        ),
        FlatButton(
          color: Theme.of(context).primaryColorLight.withOpacity(0.8),
            onPressed: (){}, child: Text(S.of(context).wishlist2text.toUpperCase(),
          style: TextStyle(color: Colors.white70),
        ))
      ],
    );
  }
}
