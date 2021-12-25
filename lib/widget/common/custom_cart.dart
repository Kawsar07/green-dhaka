import 'package:flutter/material.dart';
import 'package:green_dhaka/constraint/color.dart';
class CustomCart extends StatelessWidget {
  const CustomCart({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
        child: Container(
          padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset("assets/images/flower10.jpg"),
              ),
            SizedBox(width: 15,),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width / 2,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Belconi Box",
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                  ),
                  Text("Wooden belconi box with 5 type",overflow: TextOverflow.ellipsis,),
                  Text("500 TK",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: (){},
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: MyColor.primary,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Icon(Icons.remove,color: MyColor.whitish,size: 24,),
                          )
                        ),
                        SizedBox(width: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Text('2'),
                        ),
                        SizedBox(width: 10,),
                        GestureDetector(
                          onTap: (){},
                          child: Container(
                            width: 35,
                            height: 35,
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
            ),
          ],
        ),
      ),
    );
  }
}