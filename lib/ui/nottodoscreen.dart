import 'package:flutter/material.dart';
import 'package:not_todo/model/nodo_item.dart';
import 'package:not_todo/util/database_client.dart';



class NotToDoScreen extends StatefulWidget {
  @override
  _NotToDoScreenState createState() => _NotToDoScreenState();
}

class _NotToDoScreenState extends State<NotToDoScreen> {
  final TextEditingController _textEditingController = new TextEditingController();
  var db = new DatabaseHelper();

  void _handleSubmitted(String text) async {
    _textEditingController.clear();

    NoDoItem noDoItem = new NoDoItem(text, DateTime.now().toIso8601String());

    int savedItemId = await db.saveItem(noDoItem);

    print("Item saved id: $savedItemId");
  }
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
    var alert = new AlertDialog(
      content: new Row(
        children: <Widget>[
          new Expanded(
              child: new TextField(
                controller: _textEditingController,
                autofocus: true,
                decoration: new InputDecoration(
                  labelText: "Item",
                  hintText: "eg. Dont buy stuff!",
                  icon: new Icon(Icons.note_add),

                ),
              ))
        ],

      ),
    actions: <Widget>[
      new FlatButton(
          onPressed: () {
            _handleSubmitted(_textEditingController.text);
            _textEditingController.clear();
          }, child: Text("Save"),),
      new FlatButton(onPressed: () => Navigator.pop(context),
          child: Text("Cancel")),
    ],
    );

    showDialog(context: context,
      builder: (_) {
          return alert;
      });
  }
}
