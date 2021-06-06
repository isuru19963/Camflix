import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical:2),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent.withOpacity(0.05),
        border:Border.all(color: Colors.blue.withOpacity(0.6), width: 2),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}