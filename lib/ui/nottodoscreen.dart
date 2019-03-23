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
  final  List<NoDoItem> _itemList = <NoDoItem>[];

  @override
  void initState() {
    super.initState();

    _readNoDoList();
  }

  void _handleSubmitted(String text) async {
    _textEditingController.clear();

    NoDoItem noDoItem = new NoDoItem(text, DateTime.now().toIso8601String());
    int savedItemId = await db.saveItem(noDoItem);

    NoDoItem addedItem = await db.getItem(savedItemId);
     setState(() {
       _itemList.insert(0, addedItem);
     });
    print("Item saved id: $savedItemId");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.black87,
// Code below I am trying to add an image as a background instead of a black screen
//      decoration: new BoxDecoration(
//        image: new DecorationImage(image: new AssetImage('assets/images/darkblkgold.jpg'),
//        fit: BoxFit.cover)
//      ),
      body: new Column(
        children: <Widget>[
          new Flexible(child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: false,
              itemCount: _itemList.length,
              itemBuilder: (_, int index) {
                  return  new Card(
                    color: Colors.white10,
                    child: new ListTile(
                      title: _itemList[index],
                      onLongPress: () => debugPrint(""),
                      trailing: new Listener(
                        key:  new Key(_itemList[index].itemName),
                        child: new Icon(Icons.remove_circle,
                        color: Colors.redAccent,),
                        onPointerDown: (pointerEvent) => debugPrint(""),


                      ),

                    ),
                  );
              })),
          new Divider(
            height: 1.0,

          ),
        ],
      ),

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
    _readNoDoList() async {
    List items = await db.getItems();
    items.forEach((item) {
      NoDoItem noDoItem = NoDoItem.map(items);
      print("Db items: ${noDoItem.itemName}");
    });
    }
}
