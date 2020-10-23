import 'package:flutter/material.dart';
import './screens/notelist.dart';

Future<void> main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.amberAccent,
        primaryColor: Colors.amber,
        brightness: Brightness.light,
      ),
      title: 'Stellar Notes',
      home: Notelist(),
    ),
  );
}
