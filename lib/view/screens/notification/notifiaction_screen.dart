import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    String title = 'Test massage';
    var itemCount;

    @override
  void initState() {
          
    _firebaseMessaging.configure(
      onMessage: (message) async{
        itemCount = message;
        setState(() {
          title = message["notification"]["title"];
        });

      },

      onResume: (message) async{
        setState(() {
          title = message["data"]["title"];
        });

      },

    );
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text('Notification'),
        ),
        body: Container(
          padding: EdgeInsets.only(top:20),
          child: ListView.builder(
            itemCount: itemCount  ?? 1,
            itemBuilder: (_,__){
            return ListTile(
              leading: Image.network("https://cdn.britannica.com/45/5645-050-B9EC0205/head-treasure-flower-disk-flowers-inflorescence-ray.jpg"),
              title: Text("$title"),
              subtitle: Text('This very super hot offer for you'),
            );
          },
          ),
        ),
      ),
    );
  }
}