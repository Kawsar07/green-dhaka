import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:green_dhaka/constraint/color.dart';
class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var nameEditingController = TextEditingController();
  var addressEditingController = TextEditingController();
  var birthDayEditingController = TextEditingController();
  var genderEditingController = TextEditingController();
  var phoneEditingController = TextEditingController();
  bool isLoading = false;
  var userProfile = [];

    void saveUserProfile(){
      final firestoreInstance = FirebaseFirestore.instance;
      firestoreInstance.collection("user-profile").add({
        'name' : nameEditingController.text,
        'address': addressEditingController.text,
        'birthday': birthDayEditingController.text,
        'gender':genderEditingController.text,
        'phone':phoneEditingController.text
      }).then((value){
        print(value.id);
      });
    }
    
  final firestoreInstance = FirebaseFirestore.instance;
  Future getUserProfile() async {
    print('asdalsdas');
    setState(() {
      isLoading  = true;
    });
    firestoreInstance.collection("offer-product").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        setState(() {
          userProfile.add(result.data());
        });
      });
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getUserProfile();
    super.initState();
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.whitish,
      appBar: AppBar(
        title: Text('Edit profile'),
        centerTitle: true,
        actions: [
          IconButton(
          icon: Icon(Icons.check,color: MyColor.whitish,), 
          onPressed: (){
            saveUserProfile();
          },
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: [   
            Container(
              margin: EdgeInsets.only(top: 100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColor.success
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 80,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text('User Profile',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                  ),
                  Divider(
                    thickness: 2,
                    color: MyColor.primary,
                  ),

                  Container(  
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColor.primary),
                      borderRadius: BorderRadius.circular(5)
                    ),
                  child: Center(
                    child: TextFormField ( 
                      controller: nameEditingController,
                       onSaved: (String val) {
                        nameEditingController.text = val;
                      },
                      style: TextStyle(
                          //height: 2.0,
                          color: Colors.black                  
                      ),
                      decoration: InputDecoration(  
                        border: InputBorder.none,    
                        hintText: 'Name',
                        hintStyle: TextStyle(color: MyColor.textColor),
                        contentPadding: EdgeInsets.only(left: 10)  
                      ),  
                    ),
                  ),
                ),
                
                  Container(  
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColor.primary),
                      borderRadius: BorderRadius.circular(5)
                    ),
                  child: TextFormField ( 
                    controller: addressEditingController,
                       onSaved: (String val) {
                        addressEditingController.text = val;
                      },
                    style: TextStyle(
                        //height: 2.0,
                        color: Colors.black                  
                      ),
                    decoration: InputDecoration(  
                      border: InputBorder.none,    
                      hintText: 'Address',
                      hintStyle: TextStyle(color: MyColor.textColor),
                      contentPadding: EdgeInsets.only(left: 10)  
                    ),  
                  ),
                ),
                
                  Container(  
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColor.primary),
                      borderRadius: BorderRadius.circular(5)
                    ),
                  child: TextFormField ( 
                    controller: birthDayEditingController,
                       onSaved: (String val) {
                        birthDayEditingController.text = val;
                      },
                    style: TextStyle(
                        //height: 2.0,
                        color: Colors.black                  
                      ),
                    decoration: InputDecoration(  
                      border: InputBorder.none,    
                      hintText: 'Brithday',
                      hintStyle: TextStyle(color: MyColor.textColor),
                      contentPadding: EdgeInsets.only(left: 10)  
                    ),  
                  ),
                ),
                
                  Container(  
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColor.primary),
                      borderRadius: BorderRadius.circular(5)
                    ),
                  child: TextFormField ( 
                    controller: genderEditingController,
                       onSaved: (String val) {
                        genderEditingController.text = val;
                      },
                    style: TextStyle(
                        //height: 2.0,
                        color: Colors.black                  
                      ),
                    decoration: InputDecoration(  
                      border: InputBorder.none,    
                      hintText: 'Gender',
                      hintStyle: TextStyle(color: MyColor.textColor),
                      contentPadding: EdgeInsets.only(left: 10)  
                    ),  
                  ),
                ),
                
                  Container(  
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColor.primary),
                      borderRadius: BorderRadius.circular(5)
                    ),
                  child: TextFormField ( 
                    controller: phoneEditingController,
                      onSaved: (String val) {
                        phoneEditingController.text = val;
                      },
                    style: TextStyle(
                        // /height: 2.0,
                        color: Colors.black                  
                      ),
                    decoration: InputDecoration(  
                      border: InputBorder.none,    
                      hintText: 'Phone',
                      hintStyle: TextStyle(color: MyColor.textColor),
                      contentPadding: EdgeInsets.only(left: 10)  
                    ),  
                  ),
                ), 

                ],
              ),
            ),
            Positioned(
            top: 30,
            left: 15,
            child: Container(
              height: 120,
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('assets/images/profile.jpg',fit: BoxFit.fill,),
                ),
              ),          
             ),
            Positioned(
              top: 120,
              left: 110,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: MyColor.primary
                ),
                child: Icon(Icons.add,color: MyColor.whitish,)
                ),          
             ),
            ],
          ),
        ),
    );
  }
}