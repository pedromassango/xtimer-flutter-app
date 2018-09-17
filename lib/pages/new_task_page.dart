import 'package:flutter/material.dart';

class NewTaskPage extends StatefulWidget{
  final String title = 'X - New Task';
  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title:  new Text(widget.title, style:
        TextStyle(color: Colors.black,
            fontSize: 32.0,
            fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          new IconButton(
            icon: Icon(Icons.close, color: Colors.black, size: 32.0,),
            onPressed: (){
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 32.0),
        child: Column(
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}