
import 'package:flutter/material.dart';
import 'package:not_todo/ui/nottodoscreen.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Not ToDo App"),
        backgroundColor: Colors.black87,
      ),
      body: new NotToDoScreen(),
    );
  }
}
