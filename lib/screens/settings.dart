import 'dart:ui';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  final String themePref;
  Settings({this.themePref});
  @override
  State<StatefulWidget> createState() {
    return SettingState();
  }
}

class SettingState extends State<Settings> {
  String themePref;
  bool panelActive = false;
  SettingState({this.themePref});
  @override
  void initState() {
    super.initState();

    if (themePref == 'darkTheme') {
      setState(
        () {
          panelActive = true;
        },
      );
    } else {
      panelActive = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            letterSpacing: 2.5,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 16.5,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.contacts),
            title: Text('Contact or Report an Issue'),
            onTap: () async {
              if (await canLaunch(
                  'https://www.instagram.com/shimron.alakkal/')) {
                await launch(
                  'https://www.instagram.com/shimron.alakkal/',
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.support),
            title: Text('Contribute to Code'),
            onTap: () async {
              await _launchItemInPhone('https://www.github.com/ShimronAlakkal');
            },
          ),
          Divider(
            endIndent: 20,
            indent: 20,
            color: Colors.grey,
          ),
          ListTile(
            leading: Icon(Icons.mail_rounded),
            title: Text('Subscribe to our News Letters'),
            onTap: () async {
              await _launchItemInPhone(
                  'here is the url for news letter things');
            },
          ),
          ExpansionTile(
            leading: Icon(Icons.file_copy),
            title: Text(
              'Privacy Policy',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "BY USING THIS APP , YOU AGREE TO OUR PRIVACY POLICY STATED BELOW"
                  "\n "
                  "\n"
                  "This is an app that offers no cloud or internet services (except for the ability to the user to contact the developers"
                  " ,which is not a service provided by this app ) . None of the user's data given to the app is stored in the cloud or any "
                  "servers nor is it given to another companies , indivaiduals or any corporations in any way , other than the need for legal things."
                  " All of your data is stored "
                  "locally on your device which hosts this app . We are in no way responsible for the leak of your private data due to your lack of care or mistakes "
                  ". You will not "
                  "recieve an email or any other notification from us stating a requirement of your private data (like bank account number , drivers lisence etc.)."
                  " You agree  that we have complete "
                  "rights over the terms and conditions of this app and its services and we could change it anytime we want to along with all the above stated"
                  " terms and conditions to use our service . We value your privacy and we are always trying to not let you down in any way that we can"
                  " think of. If at all a bug or a problem is found in the app , the users are free to let the developers at STELLAR know of the problem and "
                  " a quick fix could be done to the app without (hopefully) having other damages to the user ."
                  "\n"
                  "Hope our service helps you"
                  "\n"
                  "TEAM AMBER from STELLAR",
                ),
              ),
            ],
          ),
          ExpansionTile(
            leading: Icon(Icons.group_outlined),
            title: Text(
              'Credits',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                    "Credits for the base version of Stellar's amber notes"
                    "\n "
                    "Amber notes mobile :"
                    "\n developed by Shimron Alakkal"
                    "\n Amber notes web-hostings and webside services "
                    "\n developed by Sharoon Rafeek"
                    "\n for more information , feel free to contact the developers of the app from the above option"
                    "\n onoarding svgs from freepik.com "
                    "\n Hope our service helps you"
                    "\n"
                    "TEAM AMBER from STELLAR Basics"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _launchItemInPhone(String url) async {
    if (await canLaunch(url)) {
      launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        universalLinksOnly: true,
      );
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Could not launch $url'),
        action: SnackBarAction(
            label: 'try again',
            onPressed: () {
              _launchItemInPhone(url);
            }),
      ));
    }
  }
}
