import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget{
  final String text;
  RoundedButton({Key key, @required this.text}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 160.0,
      height: 160.0,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.white,
            blurRadius: 0.0
          )
        ]
      ),
      child: Center(
        child: Text(text.toUpperCase(),
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold
        ),
        ),
      ),
    );
  }
}