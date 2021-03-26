import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/notelist.dart';
import 'package:TDM/utils/themeData.dart';

Future<void> main() async {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            
            debugShowCheckedModeBanner: false,
            theme: notifier.darkTheme == true ? dark : light,
            title: 'Paperclip',
            home: Notelist(),
          );
        },
      ),
    ),
  );
}
