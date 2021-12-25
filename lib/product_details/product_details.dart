import 'package:flutter/material.dart';
import 'package:green_dhaka/constraint/color.dart';
import 'package:green_dhaka/controllers/cart.controller.dart';
import 'package:green_dhaka/models/cart.dart';
import 'package:green_dhaka/view/screens/cart/cart.dart';
import 'package:green_dhaka/view/screens/checkout/checkout.dart';
import 'package:green_dhaka/widget/common/custom_appbar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class ProductDetails extends StatefulWidget {
  final product;
  ProductDetails({this.product});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final cartConntroller = Get.put(CartController());

  int itemCount = 0;
  increementItem(){
    setState(() {
      itemCount++;
    });
  }
   decreementItem(){
    setState(() {
      itemCount--;
    });
  }

  addTocart() {
    var data = widget.product;
    if (itemCount > 0) {
      cartConntroller.addtoCart(data, itemCount);
      // Cart().addToCart(data, itemCount);
    }
  }
  @override
  initState() {
    super.initState();
    setCartdata();
  }

  setCartdata() {
    var cartProduct = cartConntroller.getCartProduct(widget.product);

    if (cartProduct != null) {
      itemCount = cartProduct['quantity'];
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(  
          height: 50,
          child: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: (){
                      Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 15),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              //TODO cart functinonality
                            },
                             child: Container(
                              height: 40,
                              width: 40,
                              child: Image.asset('assets/images/cart.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 25,
                      top: 5,
                       child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.5),
                          color: Colors.red
                        ),
                        child: Center(child: 
                          Obx(() => 
                            Text('${cartConntroller.carts.length.toString()}',style: TextStyle(fontSize: 10,color: MyColor.whitish),)
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      bottomNavigationBar: BottomAppBar(
          child: InkWell(
            onTap: (){
              addTocart();
              Route route = MaterialPageRoute(builder: (_)=> CartPage());
              Navigator.push(context, route);
            },
            child: Container(
            color: MyColor.primary,
              padding: EdgeInsets.only(top: 10,right: 15,left: 15,bottom: 10),
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                          Container(
                            height: 40,
                            width: 40,
                            child: Image.asset('assets/images/cart.png', color: MyColor.whitish,),
                          ),
                          SizedBox(width: 15,),
                          Text('Add to Cart',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: MyColor.whitish)),             
                      ],
                    ),
                  ),
                  Text("${(int.parse(widget.product['product-price']) * itemCount).toString()}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: MyColor.whitish),),
                ],
              ),
            ),
          ),
        ),
      body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Offer",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: MyColor.textColor),),
                      SizedBox(height: 15,),
                      Card(
                        elevation: 3,
                        child: Container(
                          height: 200,
                          //color: MyColor.primary,
                          child: Swiper(
                              itemBuilder: (BuildContext context, int index) {
                                return ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 400,
                                      child: Image.network(widget.product['image'],fit: BoxFit.cover,),
                                    )

                                  ],
                                );
                              },
                           // layout: SwiperLayout.DEFAULT,
                            itemCount: 4,
                            //itemWidth: 300,
                            itemHeight: 180.0,
                            layout: SwiperLayout.DEFAULT,
                            autoplay: true,
                            pagination: SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              margin: EdgeInsets.only(
                                      top: 10,
                                ),
                            ),
                          ),
                        ),
                      ),
                        SizedBox(height: 30,),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Details",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: MyColor.textColor)),
                                Text(widget.product['product-price'] , style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: MyColor.textColor)),
                              ],
                            ),
                            SizedBox(height: 15,),
                            Text(widget.product['product-details'],textAlign: TextAlign.justify,),
                            SizedBox(height: 50,),
                            Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  decreementItem();
                                },
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: MyColor.primary,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Icon(Icons.remove,color: MyColor.whitish,size: 24,),
                                )
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30,right: 30),
                                child: Text('$itemCount',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                              ),
                              GestureDetector(
                                onTap: (){
                                  increementItem();
                                },
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: MyColor.primary,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Icon(Icons.add,color: MyColor.whitish,size: 24,),
                                )
                              )
                            ],
                          ),
                        ),
                          ],
                        ),
                      )
                    ],
                  ),
                      Positioned(
                        top: 218,
                        left: 288,
                        child: Container(
                         height: 40,
                         width: 40,
                         
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(20),
                           color: MyColor.secondary,
                           boxShadow: [
                              BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                           ]
                         ),
                         child: Center(child: InkWell(
                            onTap: () {
                              cartConntroller.addtoWishlist(widget.product);
                            },
                            child: Icon(Icons.favorite, color: Colors.pink,size: 30,))
                            ),
                          ),
                      )
                ],
              ),
            ),
          ),
      ),
    );
  }
}