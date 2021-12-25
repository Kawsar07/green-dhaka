import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
   var _site;  
   var _theme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Setting"),),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Change Language",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                ListTile(  
                  title: Text('English'),  
                  leading: Radio(  
                    value: "English",  
                    groupValue: _site,  
                    onChanged: (value) {  
                      setState(() {  
                        _site = value;  
                      });  
                    },  
                  ),  
                ),  
                ListTile(  
                  title: Text('Bangla'),  
                  leading: Radio(  
                    value: "Bangla",  
                    groupValue: _site,  
                    onChanged: ( value) {  
                      setState(() {  
                        _site = value;  
                      });  
                    },  
                  ),  
                ),
                SizedBox(height: 10,),
                Text("Change Theme",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                       ListTile(  
                  title: Text('Default'),  
                  leading: Radio(  
                    value: "Default",  
                    groupValue: _theme,  
                    onChanged: (value) {  
                      setState(() {  
                        _theme = value;  
                      });  
                    },  
                  ),  
                ),  
                ListTile(  
                  title: Text('Dark'),  
                  leading: Radio(  
                    value: "Dark",  
                    groupValue: _theme,  
                    onChanged: ( value) {  
                      setState(() {  
                        _theme = value;  
                      });  
                    },  
                  ),  
                ),
            ],
          ),
        ),
      ),
    );
  }
}