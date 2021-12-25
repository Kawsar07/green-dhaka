import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_dhaka/core/route/app_route.dart';
import 'package:get/get.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppRoute()),
  );
}






