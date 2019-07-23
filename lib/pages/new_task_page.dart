import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xtimer/model/task_model.dart';
import 'package:xtimer/widgets/numberpicker.dart';

class NewTaskPage extends StatefulWidget {
  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  TextEditingController _titleController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // time in minutes
  static const int MAX_MINUTE_ALLOWED = 120;

  // Max task title length
  static const int _maxTitleLength = 30;
  int _selectedTime = 30;

  Color getRandomColor() {
    Random r = Random();
    var colorsList = Colors.primaries;

    return colorsList.elementAt(r.nextInt(colorsList.length));
  }

  /// When called, save task and close this screen
  _saveTaskAndClose() {
    String title = _titleController.text;

    if (_formKey.currentState.validate() == false) {
      return;
    }

    var color = getRandomColor();
    var task = new Task(0, color, title, _selectedTime);

    // save task and close screen
    //TaskManager().addNewTask(task);
    Navigator.of(context).pop(task);
  }

  @override
  void initState() {
    super.initState();
    _titleController = new TextEditingController(text: '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430,
      color: Colors.white,
      margin: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: new TextFormField(
                    maxLength: _maxTitleLength,
                    maxLengthEnforced: true,
                    controller: _titleController,
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                    ),
                    validator: (String val) {
                      if (val.trim().isEmpty) return 'Task title is required.';
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Task title',
                        counterText: _maxTitleLength.toString(),
                        filled: true,
                        fillColor: Colors.white),
                  ),
                ),
                //Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(top: 42),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Time (minutes)',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: NumberPicker.horizontal(
                              initialValue: _selectedTime,
                              minValue: 10,
                              maxValue: MAX_MINUTE_ALLOWED,
                              step: 10,
                              onChanged: (value) {
                                setState(() => _selectedTime = value);
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: _saveTaskAndClose,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 50,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Save Task'.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
