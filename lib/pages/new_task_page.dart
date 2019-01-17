import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xtimer/model/task_model.dart';
import 'package:xtimer/controllers/task_manager.dart';
import 'package:xtimer/widgets/numberpicker.dart';

class NewTaskPage extends StatefulWidget {

  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  TextEditingController _titleController;

  // time in minutes
  static const  int MAX_MINUTE_ALLOWED = 120;

  // Max task title length
  int maxTitleLength = 30;
  int _selectedTime = 30;

  Color getRandomColor(){
    Random r = Random();
    var colorsList = Colors.primaries;

    return colorsList.elementAt(
        r.nextInt(colorsList.length)
    );
  }

  /// When called, save task and close this screen
  _saveTaskAndClose() {

    String title = _titleController.text;

    if(title.trim().isEmpty) return;

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
      height: 300,
        color: Colors.white,
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
        child: Stack(
          children: <Widget>[
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                new TextField(
                  maxLength: maxTitleLength,
                  controller: _titleController,
                  style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,),
                  decoration: InputDecoration(
                      hintText: 'Task title',
                      counterText: maxTitleLength.toString(),
                      filled: true,
                    fillColor: Colors.white
                  ),
                ),
                //Spacer(),
                GestureDetector(
                  onTap: (){},
                  child: Container(
                    margin: EdgeInsets.only(top: 32),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Text('Time (minutes)',
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
                              onChanged: (value){
                                setState(() => _selectedTime = value);
                              }
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            //Spacer(),

            Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                minWidth: double.maxFinite,
                onPressed: _saveTaskAndClose,
                child: Text('Save Task'.toUpperCase()),
              ),
            )
          ],
        ),
    );
  }
}
