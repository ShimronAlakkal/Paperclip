import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingState();
  }
}

class SettingState extends State<Settings> {
  bool panelActive = false;

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
      body: ListWheelScrollView(
        itemExtent: 2,
        magnification: 3,
        physics: ScrollPhysics(
          parent:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        ),
        children: [
          ListTile(
            onTap: () {
              //  code for contacting the developer by the user
            },
            title: Text(
              'Contact Developer',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            trailing: Icon(Icons.mail),
          ),
          ListTile(
            onTap: () {
              //  code for returning bug report and feedback to the developer by the user
            },
            title: Text(
              'Feedbacks or bug reports ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(
              Icons.bug_report,
            ),
          ),
          ListTile(
            onTap: () {
              //  code for returning the cresits page to the  user
            },
            title: Text(
              'Credits',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(
              Icons.library_books,
            ),
          ),
          ListTile(
            title: Text(
              'Theme',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            trailing: Switch(
              value: true,
              activeColor: Colors.amber,
              activeTrackColor: Colors.black45,
              onChanged: (value) {
                debugPrint(
                    'the switch is now pressed . so the theme is dark now ');
              },
            ),
          )
        ],
      ),
    );
  }
}

//                       'This is an app that offers no cloud or internet services . None of your data given to the app is stored in the cloud or any servers nor is it given to another company , indivaidual or any corporation in any way . All of your data is stored locally on your device which hosts the app . We are in no way responsible for the leak of your private data . You will not recieve an email or any other notification from us stating a requirement of your private data . You agree  that we have complete rights over the terms and conditions of this app ,its services and we could change it anytime we want to along with all the above stated terms and conditions to use our service . We value your privacy and we are always trying to not let you down in any way that we can think of. '),
