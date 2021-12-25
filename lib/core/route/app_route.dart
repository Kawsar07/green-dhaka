import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_dhaka/constraint/color.dart';
import 'package:green_dhaka/login/login.dart';
import 'package:green_dhaka/registration/registration.dart';
import 'package:green_dhaka/view/screens/home/home_page.dart';

class AppRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );

    // Get the firebase user
    User firebaseUser = FirebaseAuth.instance.currentUser;
    Widget firstWidget;

    // Assign widget based on availability of currentUser
    if (firebaseUser != null) {
      firstWidget = HomePage();
    } else {
      firstWidget = LoginScreen();
    }


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Green Dhaka',
      theme: ThemeData().copyWith(
        primaryColor: MyColor.primary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: firstWidget,
      // initialRoute: LoginScreen.PATH,
      // routes: {
      //   LoginScreen.PATH: (context) => LoginScreen(),
      //   Registration.PATH: (context) => Registration(),
      //   HomePage.path :(context) => HomePage()
      // },
    );
  }
}


