import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_dhaka/constraint/color.dart';
import 'package:green_dhaka/models/cart.dart';
import 'package:green_dhaka/product_details/product_details.dart';



class ProductCart extends StatefulWidget {
  const ProductCart(
      {Key key, @required this.imageID, this.productName, this.productPrice, this.product})
      : super(key: key);

  final String imageID;
  final String productName;
  final String productPrice;
  final product;

  @override
  _ProductCartState createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: GestureDetector(
        onTap: (){
          Route route = MaterialPageRoute(builder: (_)=> ProductDetails(product: widget.product,));
            Navigator.push(context, route);
        },
         child: Container(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(height: 10,),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Image.network(
                    widget.imageID,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${widget.productName}",
                      style: TextStyle(
                          color: MyColor.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.centerRight,
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Price: ",
                              style: TextStyle(
                                color: MyColor.primary,
                                fontSize: 16,
                              ),
                            ),
                          Text(
                            "${widget.productPrice}",
                              style: TextStyle(
                                color: MyColor.primary,
                                fontSize: 16,
                              ),
                            )
                        ],
                      ),
                    ),
                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Details",
                          style: TextStyle(
                            color: MyColor.primary,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: MyColor.primary,
                            size: 16,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
