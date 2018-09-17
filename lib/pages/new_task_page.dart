import 'package:flutter/material.dart';

class NewTaskPage extends StatefulWidget {
  final String title = 'New Task';

  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {

  /// When called, save task and close this screen
  void _saveTaskAndClose(){

    // close screen
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: new Text(
          widget.title,
          style: TextStyle(
              color: Colors.black, fontSize: 32.0, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          new IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.black,
              size: 32.0,
            ),
            onPressed: _saveTaskAndClose,
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50.0),
        child: Column(
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}
