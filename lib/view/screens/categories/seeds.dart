import 'package:flutter/material.dart';
import 'package:green_dhaka/constraint/color.dart';
import 'package:green_dhaka/widget/common/most_popular_cart.dart';
import 'package:green_dhaka/widget/common/plants_builder.dart';

class SeedScreen extends StatefulWidget {
  SeedScreen({Key key}) : super(key: key);

  @override
  _SeedScreenState createState() => _SeedScreenState();
}

class _SeedScreenState extends State<SeedScreen> {
  int _selectedIndex = 0;
  final padding = 8.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.whitish,
      body: Row(
        children: <Widget>[
          NavigationRail(
            minWidth: 56.0,
            groupAlignment: 1.0,
            backgroundColor: MyColor.whitish,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            leading: Column(
              children: <Widget>[
                SizedBox(
                  height: 8,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                ),
                SizedBox(
                  height: 108,
                ),
                RotatedBox(
                  quarterTurns: -1,
                  child: IconButton(
                    icon: Icon(Icons.tune),
                    color: MyColor.primary,
                    onPressed: () {},
                  ),
                )
              ],
            ),
            selectedLabelTextStyle: TextStyle(
              color:MyColor.primary,
              fontSize: 13,
              letterSpacing: 0.8,
              decoration: TextDecoration.underline,
              decorationThickness: 2.0,
            ),
            unselectedLabelTextStyle: TextStyle(
              fontSize: 13,
              letterSpacing: 0.8,
            ),
            destinations: [
              buildRotatedTextRailDestination("Rooftop", padding),   
              buildRotatedTextRailDestination("Outdoor", padding),
              buildRotatedTextRailDestination("Indoor", padding),
              buildRotatedTextRailDestination("All", padding),
            ],
          ),
          // This is the main content.
          ContentSpace(_selectedIndex)
        ],
      ),
    );
  }
}

NavigationRailDestination buildRotatedTextRailDestination(
    String text, double padding) {
  return NavigationRailDestination(
    icon: SizedBox.shrink(),
    label: Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: RotatedBox(
        quarterTurns: -1,
        child: Text(text),
      ),
    ),
  );
}

class ContentSpace extends StatefulWidget {
  final int _selectedIndex;

  ContentSpace(this._selectedIndex);

  @override
  _ContentSpaceState createState() => _ContentSpaceState();
}

class _ContentSpaceState extends State<ContentSpace> {
  List itemList = [];


  final List<String> titles = [
    "Indoor",
    "Outdoor",
    "Rooftop",
    "All"
  ];

  @override
  Widget build(BuildContext context) {
    
  var size = MediaQuery.of(context).size;
  final double itemHeight = (size.height) / 2;
  final double itemWidth = (size.width) / 2;

  
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 0, 0),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                   Container(
                        height: 40,
                        width: 40,
                        child: Image.asset('assets/images/cart.png'),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                titles[widget._selectedIndex],
                style: Theme.of(context).textTheme.headline4),
              SizedBox(
                height: 24,
              ),
              Flexible(
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(4.0),
                  childAspectRatio: (itemWidth / itemHeight),
                  children: [
                    PlantsBuilder(
                      imageID: "assets/images/plants1.png",
                      productName: "Pinus serotina",
                      productPrice: "485 TK",
                    ),
                    PlantsBuilder(
                      imageID: "assets/images/plants3.png",
                      productName: "Hemlock",
                      productPrice: "485 TK",
                    ),
                    PlantsBuilder(
                      imageID: "assets/images/plants6.png",
                      productName: "Magnolia",
                      productPrice: "485 TK",
                    ),
                    PlantsBuilder(
                      imageID: "assets/images/plants1.png",
                      productName: "Maple",
                      productPrice: "680 TK",
                    ),
                    PlantsBuilder(
                      imageID: "assets/images/plants1.png",
                      productName: "Alonda",
                      productPrice: "485 TK",
                    ),
                    PlantsBuilder(
                      imageID: "assets/images/plants3.png",
                      productName: "Nice Product",
                      productPrice: "485 TK",
                    ),
                    PlantsBuilder(
                      imageID: "assets/images/plants3.png",
                      productName: "Shortleaf ",
                      productPrice: "485 TK",
                    ),
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  final uri;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(0, 0, 24, 24),
      child: Image.network(uri),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  const ImageCard(this.uri);
}