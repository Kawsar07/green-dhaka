import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:green_dhaka/registration/registration.dart';
import 'package:green_dhaka/view/screens/home/home_page.dart';
import 'package:green_dhaka/widget/common/input_field_builder.dart';
import 'package:green_dhaka/widget/common/long_button_builder.dart';
import 'package:green_dhaka/widget/common/social_button_builder.dart';
import 'package:green_dhaka/constraint/color.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  static String PATH = "/LoginScreen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _formKey;
  var fieldKey;
  bool _passwordVisible = false;
  bool emailValid;
  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  Future isLogin()async{
    setState(() {
      isLoading = true;
    });
    try{
        final authUser = await _auth.signInWithEmailAndPassword(
        email: _emailEditingController.text, 
        password: _passwordEditingController.text
      );
      if(authUser != null){
      Route route = MaterialPageRoute(builder: (context) => HomePage());
      Navigator.push(context, route);
    }
    }catch(e){

      Fluttertoast.showToast(
        msg: "You are not registred user.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black12,
        textColor: Colors.white,
        fontSize: 16.0
      );
      print(e);
    }
      setState(() {
      isLoading = false;
    });
          
  } 
                               

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: !isLoading ? SingleChildScrollView(
          //reverse: true,
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 240,
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/login_modal.png",
                        width: 450,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, top: 20),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              //TODO sign up functionality
                              // Navigator.pushNamed(context, Registration.PATH);
                              Route route = MaterialPageRoute(builder: (_)=> Registration());
                              Navigator.push(context, route);
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                  color: MyColor.whitish, fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            child: Center(
                              child: Image.asset("assets/images/logo"
                                  ".png"),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Welcome!",
                          style: TextStyle(
                            fontFamily: 'arial',
                            letterSpacing: 3,
                            fontWeight: FontWeight.normal,
                            color: MyColor.textColor,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InputFieldBuilder(
                                iconName: 'email',
                                textFormField: Theme(
                                  data: Theme.of(context).copyWith(
                                    primaryColor: MyColor.primary,
                                  ),
                                  child: TextFormField(
                                    key: fieldKey,
                                    controller: _emailEditingController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 10, bottom: 10, left: 10),
                                        border: InputBorder.none,
                                        focusColor: MyColor.primary,
                                        suffixIcon: Icon(
                                          Icons.check,
                                          color: MyColor.primary,
                                        ),
                                        hintText: 'Please enter your email or '
                                            'phone',
                                        labelText: 'Email or Phone',
                                        labelStyle:
                                            TextStyle(color: MyColor.primary)),
                                    onSaved: (String val) {
                                      _emailEditingController.text = val;
                                    },
                                    validator: (String value) {
                                      var email = "tony@starkindustries.com";
                                      emailValid = RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(email);
                                      if (value.isEmpty) {
                                        return 'Email number is '
                                            'required';
                                      }
                                      if (emailValid == false) {
                                        return 'Wrong email';
                                      }
                                      return " ";
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              InputFieldBuilder(
                                iconName: 'password',
                                textFormField: TextFormField(
                                  controller: _passwordEditingController,
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
                                    hintText: 'Please enter your password',
                                    labelText: 'Password',
                                    labelStyle:
                                        TextStyle(color: MyColor.primary),
                                  ),
                                  onSaved: (String val) {
                                    _passwordEditingController.text = val;
                                  },
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "Password is required";
                                    }
                                    if (value.length < 6) {
                                      return 'Password too short.';
                                    }
                                    return "";
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  //TODO do something
                                },
                                child: Container(
                                  child: Text(
                                    "Forget Password?",
                                    style: TextStyle(
                                        color: MyColor.primary,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "arial",
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              LongButtonBuilder(
                                buttonText: 'Continue',
                                onPressed: (){
                                  isLogin();
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                child: Center(
                                  child: Text(
                                    "or sign in with",
                                    style: TextStyle(
                                        color: MyColor.textColor,
                                        fontFamily: "arial",
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      flex: 2,
                                      child: SocialButtonBuilder(
                                        onPressed: () {
                                          //TODO Do something
                                        },
                                        socialButtonName: 'Facebook',
                                        socialIconName: 'facebook',
                                      )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: SocialButtonBuilder(
                                        onPressed: () {
                                          //TODO Do something
                                        },
                                        socialButtonName: 'Google',
                                        socialIconName: 'google',
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ): Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
