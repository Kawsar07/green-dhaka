import 'package:flutter/material.dart';
import 'package:green_dhaka/constraint/color.dart';

class LongButtonBuilder extends StatelessWidget {
  LongButtonBuilder({@required this.buttonText, @required this.onPressed});
  final String buttonText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: MyColor.primary,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: FlatButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 17, color: MyColor.whitish, fontFamily: "arial"),
        ),
      ),
    );
  }
}
