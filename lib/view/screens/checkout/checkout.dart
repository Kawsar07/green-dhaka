import 'package:flutter/material.dart';
import 'package:green_dhaka/constraint/color.dart';
import 'package:green_dhaka/controllers/cart.controller.dart';
import 'package:green_dhaka/models/cart.dart';
import 'package:green_dhaka/product_details/product_details.dart';
import 'package:green_dhaka/view/screens/address/address_screen.dart';
import 'package:green_dhaka/view/screens/home/home_page.dart';
import 'package:green_dhaka/view/screens/success_screen/order_success.dart';
import 'package:green_dhaka/widget/common/custom_appbar.dart';
import 'package:green_dhaka/widget/common/custom_cart.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckoutPage extends StatefulWidget {

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {

  final cartConntroller = Get.put(CartController());
  var name = 'Mehedi hasan';
  var address = '160/A, Green Road, Dhaka';
  var mobile = '01790180825';
 

  bool isCashPayment = false;
  bool ePayment = false;
  bool isLoading  = false;
  var getAddress;

  sendAddress(){
    if(getAddress != null) {
     return address = getAddress['area']+" "+ getAddress['district'] +" "+ getAddress['thana'] ;
    }
  }

  var cartProducts = Cart().getCart;

    void _awaitReturnValueFromSecondScreen(BuildContext context) async {

    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddAddressRoute(),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      getAddress = result;
 
    });
  }

  getTotal() {
    var total = 0;
    cartConntroller.carts.forEach((item) {
      total += item['total-price'];
    });
    return total.toString();
  }

  Future createOrder() async {
      final firestoreInstance = FirebaseFirestore.instance;
     await firestoreInstance.collection("order-list").add({
        'total' : getTotal(),
        'items': cartConntroller.carts,
        'user_id': 1,
        'name': name,
        'address': getAddress != null ? sendAddress() : address,
        'mobile': getAddress != null ? getAddress['phone']:mobile,
        'payment_type': 'Cash on delivery',
        'coupon_code': 'BOISHAKH'
      }).then((value){
        print(value);
        print(value.id);
        cartConntroller.clearCart();
      });
  }
  
  Widget build(BuildContext context) {
  print("getAddress : $getAddress");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          height: 50,
          child: Container(
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
                Container(
                  padding: EdgeInsets.only(right: 15),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: (){
                          Route route = MaterialPageRoute(builder: (_)=>HomePage());
                          Navigator.push(context, route);
                        },
                        icon: Icon(Icons.cancel,size: 30,),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: GestureDetector(
            onTap: ()async{   
              if (cartConntroller.carts.length < 1) {
                return;
              }
              setState(() {
                isLoading = true;
              });
             await createOrder();
              setState(() {
                isLoading = false;
              });
              Route route = MaterialPageRoute(builder: (_)=> OrderSuccess());
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
                  Text('Total',style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal,color: MyColor.whitish)),
                  Text(getTotal(), style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: MyColor.whitish),),
                ],
              ),
              Container(
                child: Row(
                  children: [
                    Text('Place order',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: MyColor.whitish)),
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
        body:!isLoading ? SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Checkout",
                    style: TextStyle(
                      color: MyColor.textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              Text('Shipping Address',style: TextStyle(color: MyColor.textColor,fontSize: 16 ),),
                              Text("Mehedi Hasan",style: TextStyle(color: MyColor.textColor,fontSize: 16,fontWeight: FontWeight.bold )),
                              Row(
                                children: [   
                                  Text(getAddress != null ? getAddress['address']: 'House # 221/2',style: TextStyle(color: MyColor.textColor,fontSize: 16 )),
                                  Text(', '),
                                  Text(getAddress != null ? getAddress['thana']: 'Pullobi',style: TextStyle(color: MyColor.textColor,fontSize: 16 )),
                                  Text(', '),
                                  Text(getAddress != null ? getAddress['district']: 'Dhaka',style: TextStyle(color: MyColor.textColor,fontSize: 16 )),
                                ],
                              ),
                              Text("Bangladesh",style: TextStyle(color: MyColor.textColor,fontSize: 16 )),
                              Text(getAddress != null ? "Mobile: " + getAddress['phone']: "Mobile: 01790180825",style: TextStyle(color: MyColor.textColor,fontSize: 16 )),
                            ],
                          ),
                        ),
                        RawMaterialButton(
                          onPressed: (){
                            _awaitReturnValueFromSecondScreen(context);
                            // Route route = MaterialPageRoute(builder: (_)=>AddAddressRoute());
                            // Navigator.push(context, route);
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: MyColor.primary,
                              borderRadius: BorderRadius.circular(8),

                            ),
                            child: Icon(Icons.arrow_forward_ios,color: MyColor.whitish,),
                            ),
                        )
                      ],
                    ),
                  ),
              
                
                  SizedBox(height: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text('Payment Method',style: TextStyle(color: MyColor.textColor,fontSize: 20,fontWeight: FontWeight.bold )),
                      InkWell(
                        onTap: (){
                          setState(() {
                            isCashPayment = true;
                            ePayment = false;
                          });
                          
                        },
                          child: Card(
                            color: isCashPayment ? MyColor.primary : MyColor.whitish,
                            child: Container(
                            height: 44,
                              padding: EdgeInsets.only(left: 10,top: 10),
                              child: Row(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Row(  
                                      children: [
                                        Icon(Icons.credit_card),
                                        SizedBox(width: 10,),
                                        Text("Cash on delivery"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                              ),
                          ),
                        ),
                      ),
                  
                      InkWell(
                        onTap: (){
                          setState(() {
                            ePayment = true;
                            isCashPayment = false;
                          });
                        },
                        child: Card(   
                            color: ePayment ? MyColor.primary : MyColor.whitish,
                            child: Container(
                              height: 44,
                              padding: EdgeInsets.only(left: 10,top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Row(  
                                        children: [
                                          Icon(Icons.credit_card),
                                          SizedBox(width: 10,),
                                          Text("MasterCard"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                
                    ],
                  ),
                  SizedBox(height: 15,),
                  Text('Order Items',style: TextStyle(color: MyColor.textColor,fontSize: 20,fontWeight: FontWeight.bold )),
                  
                  Obx(() =>
                    Column(
                      children: cartConntroller.carts.map((item) {
                        return GestureDetector(
                          onTap: () {
                            Route route = MaterialPageRoute(builder: (_)=> ProductDetails(product: item,));
                            Navigator.push(context, route);
                          },
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Route route = MaterialPageRoute(builder: (_)=> ProductDetails(product: item,));
                                  Navigator.push(context, route);
                                },
                                child: Card(
                                elevation: 3,
                                  child: Container(
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
                                            height: 100,
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
                              ),
                              SizedBox(height: 15,),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  
                  
                Container(
                    width: double.infinity,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: MyColor.primary)
                    ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Expanded(
                          child: Container(  
                            child: TextField ( 
                              style: TextStyle(
                                  height: 2.0,
                                  color: Colors.black                  
                                ),
                              decoration: InputDecoration(  
                                border: InputBorder.none,    
                                hintText: 'Coupon Code',
                                contentPadding: EdgeInsets.only(left: 10,bottom: 10)  
                              ),  
                              ),
                          ),
                        ),  
                        RawMaterialButton(
                          onPressed: (){},
                          child: Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                            color: MyColor.primary,
                            borderRadius: BorderRadius.circular(5),

                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(width: 5,),
                              Text("Apply Coupon",style: TextStyle(color: MyColor.whitish,fontSize: 16),),
                              Icon(Icons.arrow_forward_ios,color: MyColor.whitish,),
                            ],
                          ),
                          ),
                      ),
                      SizedBox(width: 1,),
                    ],
                  ),
                ),
                
                  ],
              ),
            ),
          ),
        ) : Center(child: CircularProgressIndicator()),

    );
    
  }
}