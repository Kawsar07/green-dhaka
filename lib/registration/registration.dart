import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_dhaka/constraint/color.dart';
import 'package:green_dhaka/view/screens/home/home_page.dart';
import 'package:green_dhaka/widget/common/input_field_builder.dart';
import 'package:green_dhaka/widget/common/long_button_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Registration extends StatefulWidget {
  static String PATH = "/Registration";
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  var _formKey;
  var fieldKey;
  bool _passwordVisible = false;
  final _auth = FirebaseAuth.instance;

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  bool isLoading = false; 
   Future isRegistration()async{
    setState(() {
      isLoading = true;
    });
       try{
        final newUser = await _auth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
        if(newUser != null){  
          saveProfileInfo();   
          Route route = MaterialPageRoute(builder: (_)=> HomePage());
           Navigator.push(context, route);
          // Navigator.pushNamed(context, HomePage.path);
        }  
      }on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
                Fluttertoast.showToast(
              msg: "You have already registred",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black12,
              textColor: Colors.white,
              fontSize: 16.0
            );
        }
      } catch(e) {
      print(e);
      }
      setState(() {
      isLoading = false;
    });
          
  } 
  
   void saveProfileInfo(){
      final firestoreInstance = FirebaseFirestore.instance;
      firestoreInstance.collection("profileInfo").add({
        'userName' : userNameController.text,
        'userEmail': emailController.text,
        'userPhone': phoneNumberController.text,
        'userPassword':passwordController.text
      }).then((value){
        print(value.id);
      });
    }
    
    bool validateEmail(String value) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      return (!regex.hasMatch(value)) ? false : true;
    }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: !isLoading ? SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 50, bottom: 50),
                      child: Image.asset('assets/images/logoBig.png'),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InputFieldBuilder(
                            iconName: 'person',
                            textFormField: TextFormField(
                              controller: userNameController,
                              key: fieldKey,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 10),
                                border: InputBorder.none,
                                suffixIcon: Icon(
                                  Icons.check,
                                  color: MyColor.primary,
                                ),
                                hintText: 'Please enter your full name',
                                labelText: 'Full name',
                                labelStyle: TextStyle(color: MyColor.primary),
                              ),
                              onSaved: (String val) {
                                userNameController.text = val;
                              },
                              validator: (String value) {
                                validateEmail(value);
                                return "";
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InputFieldBuilder(
                            iconName: 'email',
                            textFormField: TextFormField(
                              controller: emailController,
                              key: fieldKey,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 10),
                                border: InputBorder.none,
                                suffixIcon: Icon(
                                  Icons.check,
                                  color: MyColor.primary,
                                ),
                                hintText: 'Please enter your email',
                                labelText: 'Email address',
                                labelStyle: TextStyle(color: MyColor.primary),
                              ),
                              onSaved: (String val) {
                                emailController.text = val;
                              },
                              validator: (String value) {
                                return value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InputFieldBuilder(
                            iconName: 'phone',
                            textFormField: TextFormField(
                              controller: phoneNumberController,
                              key: fieldKey,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 10),
                                border: InputBorder.none,
                                suffixIcon: Icon(
                                  Icons.check,
                                  color: MyColor.primary,
                                ),
                                hintText: 'Please enter your phone',
                                labelText: 'Phone number',
                                labelStyle: TextStyle(color: MyColor.primary),
                              ),
                              onSaved: (String val) {
                                phoneNumberController.text = val;
                              },
                              validator: (String value) {
                                return value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InputFieldBuilder(
                            iconName: 'password',
                            textFormField: TextFormField(
                              controller: passwordController,
                              key: fieldKey,
                              obscureText: !_passwordVisible,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 10),
                                border: InputBorder.none,
                                suffixIcon: GestureDetector(
                                  onLongPress: () {
                                    setState(() {
                                      _passwordVisible = true;
                                    });
                                  },
                                  onLongPressUp: () {
                                    setState(() {
                                      _passwordVisible = false;
                                    });
                                  },
                                  child: _passwordVisible
                                      ? Icon(
                                          Icons.visibility_off,
                                          color: MyColor.primary,
                                        )
                                      : Icon(
                                          Icons.visibility_off,
                                          color: MyColor.primary,
                                        ),
                                ),
                                hintText: 'Please enter your email password',
                                labelText: 'Password',
                                labelStyle: TextStyle(color: MyColor.primary),
                              ),
                              onSaved: (String val) {
                                passwordController.text = val;
                              },
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Password needed";
                                }
                                return "";
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Container(
                      child: LongButtonBuilder(
                        buttonText: 'Create an account',
                        onPressed: (){
                         isRegistration();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("By signing up, you agree to our"),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Terms ',
                                    style: TextStyle(
                                      color: MyColor.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(' and '),
                                  Text(' Conditions of Use',
                                      style: TextStyle(
                                        color: MyColor.primary,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ) : Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}

