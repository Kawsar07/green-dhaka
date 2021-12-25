import 'package:flutter/material.dart';
import 'package:green_dhaka/constraint/color.dart';

class SocialButtonBuilder extends StatelessWidget {
  SocialButtonBuilder(
      {this.socialButtonName, @required this.onPressed, this.socialIconName});
  final String socialButtonName;
  final Function onPressed;
  final String socialIconName;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: MyColor.whitish,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(
          color: MyColor.primary,
          width: 2,
        ),
      ),
      child: FlatButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/$socialIconName"
                ".png"),
            SizedBox(
              width: 8,
            ),
            Text(
              socialButtonName,
              style: TextStyle(
                  fontSize: 17, color: MyColor.primary, fontFamily: "arial"),
            )
          ],
        ),
      ),
    );
  }
}
