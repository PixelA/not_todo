import 'package:flutter/material.dart';
import 'package:not_todo/ui/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Not ToDo App',
      home: new Home(),
    );
  }
}



