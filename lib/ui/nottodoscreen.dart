import 'package:flutter/material.dart';



class NotToDoScreen extends StatefulWidget {
  @override
  _NotToDoScreenState createState() => _NotToDoScreenState();
}

class _NotToDoScreenState extends State<NotToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(),

      floatingActionButton: new FloatingActionButton(
          tooltip: "Add Item",
          backgroundColor: Colors.yellow,
          child: new ListTile(
            title: new Icon(Icons.add),

          ),
          onPressed: _showFormDialog),
    );
  }

  void _showFormDialog() {
  }
}
