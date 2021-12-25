import 'package:flutter/material.dart';
import 'package:green_dhaka/constraint/color.dart';
import 'package:green_dhaka/controllers/cart.controller.dart';
import 'package:green_dhaka/view/screens/cart/cart.dart';
import 'package:green_dhaka/widget/common/custom_appbar.dart';
import 'package:green_dhaka/widget/common/product_cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class AllProductScreen extends StatefulWidget {
  @override
  _AllProductScreenState createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {

  final cartConntroller = Get.put(CartController());

  final firestoreInstance = FirebaseFirestore.instance;
  var products = [];
  var allProducts = [];
  bool isLoading = false;

  Future getAllProducts() async {

    setState(() {
      isLoading  = true;
    });
    await firestoreInstance.collection("all-product").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
       // print(result.data());
        setState(() {
          allProducts.add(result.data());
        });
        products = allProducts;
      });
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  initState() {
    super.initState();
    getAllProducts();
  }

  searchProduts(query) {
    var data = allProducts.where((item) => item['product-name'].toLowerCase().contains(query.toLowerCase())).toList();
    setState(() {
      products = data;
    });
  }

  @override
  Widget build(BuildContext context) {
  var size = MediaQuery.of(context).size;
  final double itemHeight = (size.height) / 2.2;
  final double itemWidth = (size.width) / 2;
    return Scaffold(
      appBar: CustomAppBar(
          height: 120,
          child: Column(
            children: [
              Container(
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
                        )
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
                                  Route route = MaterialPageRoute(builder: (_)=> CartPage());
                                  Navigator.push(context, route);
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
                            child: Center(
                              child: Obx(() => 
                                Text('${cartConntroller.carts.length.toString()}', style: TextStyle(fontSize: 10,color: MyColor.whitish),)
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.only(left: 15,right: 15),
                child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Container(
                          height: 44,
                          child: TextFormField(
                            onChanged: (value) {
                              searchProduts(value);
                            },
                            decoration: new InputDecoration(
                              suffixIcon: Icon(Icons.search),
                              labelText: "Search...",
                              labelStyle: TextStyle(color: Colors.black),
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                borderSide: new BorderSide(),
                              ),
                              //fillColor: Colors.green
                            ),
                            validator: (val) {
                              if (val.length == 0) {
                                return "Email cannot be empty";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ),
                    
                    ],
                  ),
              ),
              
            ],
          ),
        ),
      body: Container(
        padding: EdgeInsets.only(left: 12, right: 15),
        height: MediaQuery.of(context).size.height / 1.2,
        child: GridView.count(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
           childAspectRatio: (itemWidth / itemHeight),
          children: List<Widget>.generate(products.length, (index) {
            return GridTile(
              child: Container(
                height: 200,
                child: ProductCart(
                  imageID: products[index]['image'],
                  productName: products[index]['product-name'],
                  productPrice: products[index]['product-price'] + "\$",
                  product: products[index]
              ),
              )
            );
          }),
        ),
      ),
    ); 
  }
}