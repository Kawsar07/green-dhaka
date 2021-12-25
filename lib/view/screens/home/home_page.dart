import 'package:flutter/material.dart';
import 'package:green_dhaka/constraint/color.dart';
import 'package:green_dhaka/controllers/cart.controller.dart';
import 'package:green_dhaka/product_details/product_details.dart';
import 'package:green_dhaka/view/screens/all_product/all_product_screen.dart';
import 'package:green_dhaka/view/screens/cart/cart.dart';
import 'package:green_dhaka/view/screens/categories/plants.dart';
import 'package:green_dhaka/view/screens/categories/seeds.dart';
import 'package:green_dhaka/view/screens/sidebar/sidebar.dart';
import 'package:green_dhaka/widget/common/catagory_builder.dart';
import 'package:green_dhaka/widget/common/custom_appbar.dart';
import 'package:green_dhaka/widget/common/custom_bottom_bar.dart';
import 'package:green_dhaka/widget/common/most_popular_cart.dart';
import 'package:green_dhaka/widget/common/offer_card_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_dhaka/widget/common/product_cart.dart';
import 'package:get/get.dart';


class HomePage extends StatefulWidget {
  static final String path = "HomePage";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final cartConntroller = Get.put(CartController());

  final _auth = FirebaseAuth.instance;
  var popularProducts = [];
  var offerProducts = [];
  var isLoading = false;
  var _searchController = TextEditingController();


  final firestoreInstance = FirebaseFirestore.instance;
  
  var products = [];
  var allProducts = [];
  //var reviews = [];

  Future getAllProducts() async {

    setState(() {
      isLoading  = true;
    });
    firestoreInstance.collection("all-product").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
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

  //   Future getReviews() async {

  //   await firestoreInstance.collection("appReviews").get().then((querySnapshot) {
  //     querySnapshot.docs.forEach((result) {
  //       print(result.data());
  //       setState(() {
  //         reviews.add(result.data());
  //         print(reviews);
  //       });
  //     });
  //   });
  // }
    var reviews = [];

    final firestoreInstances = FirebaseFirestore.instance.collection("appReviews");
    Future fatchReviews()async{
    firestoreInstances.get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        setState(() {
         reviews.add(result.data());
        });
      print("reviews $reviews");
      });
     });
    }

  var data;
  searchProduts(query) {
    data = allProducts.where((item) => item['product-name'].toLowerCase().contains(query.toLowerCase())).toList();
    setState(() {
      products = data;
    });
  }


  Future getPopularProducts() async {

    setState(() {
      isLoading  = true;
    });
    firestoreInstance.collection("popular-product").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        setState(() {
          popularProducts.add(result.data());
        });
      });
    });

    setState(() {
      isLoading = false;
    });
  }

  Future getOfferProducts() async {
    print('asdalsdas');
    setState(() {
      isLoading  = true;
    });
    firestoreInstance.collection("offer-product").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        setState(() {
          offerProducts.add(result.data());
        });
      });
    });

    setState(() {
      isLoading = false;
    });
  }

  User loggedInUser;
 
  @override
    void initState() {
      super.initState();
      getCurrentUser();
      getPopularProducts();
      getOfferProducts();
      getAllProducts();
      fatchReviews();
}

  void getCurrentUser(){
    final _user =  _auth.currentUser;
    if(_user != null){
      loggedInUser = _user;
    }
  }

  getProducts() {

  }

  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
  final double itemHeight = (size.height) / 2.2;
  final double itemWidth = (size.width) / 2;
    return SafeArea(
      child: BaseNavLayout(
        scaffoldKey: _scaffoldKey,
        drawer: Drawer(
          child: SideBar(),
        ),
        appBar: CustomAppBar(
          height: 120,
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          child: Image.asset('assets/images/menu.png'),
                          onTap: () => _scaffoldKey.currentState.openDrawer(),
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
              SizedBox(height: 20,),
              Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Container(
                          height: 44,
                          child: TextFormField(
                            controller: _searchController,
                            decoration: new InputDecoration(
                              suffixIcon: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: MyColor.primary,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Icon(Icons.search,color: MyColor.whitish,),
                                ),
                              labelText: "Search...",
                              labelStyle: TextStyle(color: Colors.black),
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                borderSide: new BorderSide(),
                              ),
                              //fillColor: Colors.green
                            ),
                            onChanged: (value){
                              searchProduts(value);
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
        body: data != null &&  _searchController.text.isNotEmpty? Container(
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
         ) : SingleChildScrollView(
          child: !isLoading ?  Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Offer',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: MyColor.textColor,
                              ),
                            ),
                            GestureDetector(
                               onTap: () {
                                Route route = MaterialPageRoute(builder: (_)=> AllProductScreen()); 
                                Navigator.push(context, route);
                              },
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "View All",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff2F434C),
                                      ),
                                    ),
                                   
                                     Container(
                                        child: Icon(
                                          Icons.keyboard_arrow_right,
                                          size: 30,
                                          color: MyColor.textColor,
                                        ),
                                     ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Container(
                          height: 140,
                          
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              ...offerProducts.map((item) {
                                return Row(
                                  children: [
                                    OfferCartBuilder(
                                      imageID: item['image'],
                                      //foodName: item['product-name'],
                                      product: item,
                                      onTap: (){
                                        Route route = MaterialPageRoute(builder: (_)=> ProductDetails(product: item,));
                                        Navigator.push(context, route);
                                      },
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                  ],
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Categories',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: MyColor.textColor,
                              ),
                            ),
                            GestureDetector(                             
                              onTap: () {
                                Route route = MaterialPageRoute(builder: (_)=>AllProductScreen()); 
                                Navigator.push(context, route);
                              },
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "View All",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff2F434C),
                                      ),
                                    ),
                                   
                                  Container(
                                        child: Icon(
                                          Icons.keyboard_arrow_right,
                                          size: 30,
                                          color: MyColor.textColor,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Container(
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              CategoryBuilder(
                                onTap: () {
                                  Route route = MaterialPageRoute(builder: (_)=> PlantScreen());
                                  Navigator.push(context, route);
                                },
                                imageID: '1',
                                categoryName: 'Plants',
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              CategoryBuilder(
                                onTap: (){ 
                                   Route route = MaterialPageRoute(builder: (_)=> SeedScreen());
                                  Navigator.push(context, route);
                                },
                                imageID: '2',
                                categoryName: 'Seeds',
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              CategoryBuilder(
                                imageID: '3',
                                categoryName: 'Flowers',
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              CategoryBuilder(
                                imageID: '4',
                                categoryName: 'Sprayers',
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              CategoryBuilder(
                                imageID: '5',
                                categoryName: 'Pots',
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              CategoryBuilder(
                                imageID: '6',
                                categoryName: 'Fertilizers',
                              ),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Most Popular',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: MyColor.textColor,
                            ),
                          ),
                          GestureDetector(
                             onTap: () {
                                Route route = MaterialPageRoute(builder: (_)=>AllProductScreen()); 
                                Navigator.push(context, route);
                              },
                              child: Container(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "View All",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff2F434C),
                                    ),
                                  ),
                               
                                   Container(
                                      child: Icon(
                                        Icons.keyboard_arrow_right,
                                        size: 30,
                                        color: MyColor.textColor,
                                      ),
                                    ),
                                
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                     padding: EdgeInsets.only(left: 12, right: 15),
                      height: MediaQuery.of(context).size.height / 1.2,
                      child: Flexible(
                         child: GridView.count(
                          primary: false,
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: (itemWidth / itemHeight),
                          children: <Widget>[
                            ...popularProducts.map((item) {
                              return MostPopularCart(
                                imageID: item['image'],
                                productName: item['product-name'],
                                productPrice: item['product-price'],
                                product: item
                              );
                            }).toList()
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                 Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Reviews',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: MyColor.textColor,
                            ),
                          ),
                    ),
                ),
                Column(
                  children: [

                    ...reviews.map((review) {
                      return Reviews(
                        name: review['name'],
                        reviewMassage: review['ratingMassage'],
                        rating: review['rating'],
                      );
                    }),

                  ],
                ),
                
              ],
            ),
          ) :  CircularProgressIndicator() ,
        ),
      ),
    );
  }
}


class Reviews extends StatelessWidget {
  Reviews({this.name, this.rating, this.reviewMassage});
  final String name;
  final String reviewMassage;
  final String rating;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Expanded(
            child: ListTile(
              leading: Image.asset('assets/images/profile'
                  '.png'),
              title: Text(name),
              subtitle: Text(
                reviewMassage,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Container(
                  width: 50,
                  height: 25,
                  decoration: BoxDecoration(
                    color: MyColor.secondary,
                    borderRadius: BorderRadius.circular(15) 
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        rating,
                        style: TextStyle(
                          fontSize: 18,
                          color: MyColor.primary,
                        ),
                      ),
                      Icon(
                        Icons.star,
                        size: 18,
                        color: MyColor.primary,
                      ),
                    ],
                  )),
            ),
         ),
      
        
      ],
    );
  }
}
