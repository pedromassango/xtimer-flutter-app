import 'package:flutter/material.dart';

class RoundedButton extends StatefulWidget{
  final String text;
  RoundedButton({Key key, @required this.text}): super(key: key);

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton>{

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 140.0,
      height: 140.0,
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
        child: Text(widget.text.toUpperCase(),
          style: TextStyle(
              fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}