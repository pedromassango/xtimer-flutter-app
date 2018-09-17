import 'package:flutter/material.dart';
import 'package:xtimer/model/task_model.dart';

class NewTaskPage extends StatefulWidget {
  final String title = 'New Task';

  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {

  TextEditingController _titleController, _timeController;

  /// When called, save task and close this screen
  void _saveTaskAndClose(){

    int minutes = int.parse(_timeController.text);
    String title = _titleController.text;

    var task = new Task(Colors.brown, title, minutes);

    //TODO: save task in database

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
        margin: EdgeInsets.only(top: 90.0),
        padding: EdgeInsets.only(left: 40.0, right: 40.0),
        child: Column(
          children: <Widget>[
            new TextField(
              controller: _titleController,
              style: TextStyle(fontSize: 24.0, color: Colors.black, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: 'Title',
                counterText: '30',
                filled: true
              ),
            ),

            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 32.0, left: 70.0, right: 70.0),
              child: new TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                controller: _timeController,
                style: TextStyle(fontSize: 14.0, color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Time (in minutes)',
                  filled: true
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
