import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingState();
  }
}

class SettingState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              //  code for contacting the developer by the user
            },
            title: Text(
              'Contact Developer',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
            ),
            trailing: Icon(Icons.mail),
          ),
          ListTile(
            onTap: () {
              //  code for returning bug report and feedback to the developer by the user
            },
            title: Text('Feedbacks or bug reports ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            trailing: Icon(
              Icons.bug_report,
            ),
          ),

          ListTile(
            onTap: () {
              //  code for returning the cresits page to the  user
            },
            title: Text('Credits',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            trailing: Icon(
              Icons.library_books,
            ),
          ),

          ListTile(
            onTap: () {
              //  code for returning the privacy policy statement to the user
            },
            title: Text('Privacy Policy',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            trailing: Icon(
              Icons.info_outline
            ),
          ),
        ],
      ),
    );
  }
}
