import 'package:flutter/material.dart';
import './screens/notelist.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.amberAccent,
        primaryColor: Colors.amber,
      ),
      title: 'ToDoManager',
      home: Notelist(), 
    ),
  ); // runApp
}
