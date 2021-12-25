import 'package:flutter/material.dart';
import 'package:green_dhaka/constraint/color.dart';

class CategoryBuilder extends StatelessWidget {
  const CategoryBuilder(
      {Key key, @required this.imageID, this.categoryName, this.onTap})
      : super(key: key);

  final String imageID;
  final String categoryName;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 3,
            child: Container(
              width: 50,
              height: 50,
              padding: EdgeInsets.all(10),
              child: Image.asset(
                'assets/images/catagory$imageID.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Text(
            "$categoryName",
            style: TextStyle(
              color: MyColor.primary,
              fontSize: 14,
            ),
          ),
        )
      ],
    );
  }
}
