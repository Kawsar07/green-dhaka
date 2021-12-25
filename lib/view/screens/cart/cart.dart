import 'package:flutter/material.dart';
import 'package:green_dhaka/constraint/color.dart';
import 'package:green_dhaka/controllers/cart.controller.dart';
import 'package:green_dhaka/models/cart.dart';
import 'package:green_dhaka/product_details/product_details.dart';
import 'package:green_dhaka/view/screens/checkout/checkout.dart';
import 'package:green_dhaka/widget/common/custom_appbar.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

    final cartConntroller = Get.put(CartController());
    var cartProducts = Cart().getCart;
  
  getCartProducts() {

  }

  getTotal() {
    var total = 0;
    cartConntroller.carts.forEach((item) {
      total += item['total-price'];
    });
    return total.toString();
  }
  // getTotal() {
  //   var total = 0;
  //   cartProducts.forEach((item) {
  //     print("item");
  //     print(item['total-price']);
  //     total += item['total-price'];
  //   });
  //   return total.toString();
  // }

@override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        print("get total");
    print(getTotal());
    return Scaffold(
      appBar: CustomAppBar(
          height: 50,
          child: Container(
            color: MyColor.whitish,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
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
          child:GestureDetector(
            onTap: (){
              Route route = MaterialPageRoute(builder: (_)=> CheckoutPage());
              Navigator.push(context, route);
            },
            child: Container(
              color: MyColor.primary,
              padding: EdgeInsets.only(top: 10,right: 15,left: 15,bottom: 10),
              height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total', style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal,color: MyColor.whitish)),
                            Text(getTotal(), style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: MyColor.whitish),)
                          ],
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text('Checkout',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: MyColor.whitish)),
                              SizedBox(width: 15,),
                              Container(
                                child: Icon(Icons.arrow_forward,color: MyColor.whitish,),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Container(
            color: MyColor.whitish,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cart",
                  style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: MyColor.textColor
                  ),
                ),
                SizedBox(height: 20,),
                ...cartConntroller.carts.map((item) {
                  return GestureDetector(
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (_)=> ProductDetails(product: item,));
                      Navigator.push(context, route);
                    },
                    child: Card(
                    elevation: 3,
                      child: Container(
                        //padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.network(item['image']),
                              ),
                              SizedBox(width: 15,),

                          Container(
                                    padding: EdgeInsets.only(bottom: 10),
                                    height: 120,
                                    width: MediaQuery.of(context).size.width / 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          item['product-name'],
                                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                        ),
                                        Text(item['product-details'], overflow: TextOverflow.ellipsis,),
                                        Text( "Price: "+item['total-price'].toString() + " TK",style: TextStyle(fontSize: 18),),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              
                                              Text("Quantity: ${item['quantity'].toString()}",style: TextStyle(color: MyColor.primary, fontSize: 16,fontWeight: FontWeight.bold),),
                                              InkWell(
                                                child: Icon(Icons.delete_forever_outlined,size: 28,color: Colors.redAccent,), 
                                                onTap: (){
                                                  setState(() {
                                                     cartConntroller.removeCartItem(item);
                                                  });
                                                 
                                                }
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  
                            ],
                          ),
                        ),
                      ),
                  );
                }).toList()
              
              ],
            ),
          ),
        ),
    );
  }
}

