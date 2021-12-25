import 'package:flutter/material.dart';
import 'package:green_dhaka/constraint/color.dart';

class InputFieldBuilder extends StatelessWidget {
  InputFieldBuilder({
    Key key,
    this.fieldKey,
    @required this.iconName,
    @required this.textFormField,
  }) : super(key: key);
  final String iconName;
  final Key fieldKey;
  final Widget textFormField;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: MyColor.secondary,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Image.asset("assets/images/$iconName"
                ".png"),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 6,
          child: Container(
            child: textFormField,
          ),
        )
      ],
    );
  }
}

/*
 TextFormField(
            obscureText: levelText == "Password" ? _obscureText : false,
            key: fieldKey,
            keyboardType: keyboardType,
            decoration: InputDecoration(
//              filled: true,
//              fillColor:
//                  Colors.white.withOpacity(0.5),
              contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
              border: InputBorder.none,
              suffixIcon: suffixIcon,
              hintText: hintText,
              labelText: levelText,
            ),
            onSaved: onSave,
            validator: validator,
          ),
 */
