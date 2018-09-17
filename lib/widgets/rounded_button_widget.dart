import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 160.0,
      height: 160.0,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Center(
        child: Text('Start'),
      ),
    );
  }
}