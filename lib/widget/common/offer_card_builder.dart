import 'package:flutter/material.dart';
import 'package:green_dhaka/constraint/color.dart';
class OfferCartBuilder extends StatelessWidget {
  const OfferCartBuilder({
    Key key,
    @required this.imageID,
    //this.foodName,
    this.product,
    this.onTap
  }) : super(key: key);
  final String imageID;
  //final String foodName;
  final product;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
          child: Card(
        elevation: 3,
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5.0),
                topLeft: Radius.circular(5.0),
              ),
              child: Image.network(
                imageID,
                width: 240,
                height: 132,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Discount",
                    style: TextStyle(
                      color: MyColor.primary,
                      fontSize: 14,
                    ),
                  ),
                  Text(product['discount-persent'] + '%',
                      style: TextStyle(
                        color: MyColor.primary,
                        fontSize: 35,
                      )),
                  Text("View details",
                      style: TextStyle(
                        color: MyColor.primary,
                        fontSize: 14,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}