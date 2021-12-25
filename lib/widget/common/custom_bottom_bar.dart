import 'package:flutter/material.dart';
import 'package:green_dhaka/constraint/color.dart';
import 'package:green_dhaka/view/screens/favorite/favorite.dart';
import 'package:green_dhaka/view/screens/home/home_page.dart';
import 'package:green_dhaka/view/screens/my_order/my_order.dart';

class BaseNavLayout extends StatefulWidget {
  BaseNavLayout({this.appBar,this.body,this.drawer,this.scaffoldKey});

  final Widget appBar;
  final Widget body;
  final Drawer drawer;
  final GlobalKey<ScaffoldState> scaffoldKey; 

  @override
  _BaseNavLayoutState createState() => _BaseNavLayoutState();
}

class _BaseNavLayoutState extends State<BaseNavLayout> {
  bool isSelecteted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: widget.scaffoldKey,
        backgroundColor: Colors.white,
        drawer: widget.drawer,
        appBar:widget.appBar ,
        body: widget.body,
      bottomNavigationBar:BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        color: Color(0xffffffff).withOpacity(0.01),
        elevation: 9.0,
        child: Container(
          height: 65.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25.0), topLeft: Radius.circular(25.0)),
            color: MyColor.primary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50.0,
                child: MaterialButton(
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  onPressed: (){
                    Route route = MaterialPageRoute(builder: (context) => FavoritePage());
                    Navigator.push(context, route);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset('assets/images/favorite.png'),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50.0,
                child: MaterialButton(
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  onPressed: (){
                       Route route = MaterialPageRoute(builder: (context) => HomePage());
                        Navigator.push(context, route);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset('assets/images/home.png'),
            
                    ],
                  ),
                ),
              ),
              Container(
                height: 50.0,
                child: MaterialButton(
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  onPressed: (){
                          Route route = MaterialPageRoute(builder: (context) => MyOrderPage());
                          Navigator.push(context, route);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset('assets/images/nav_cart.png'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
          
);
  }
}
