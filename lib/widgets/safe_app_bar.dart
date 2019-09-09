import 'package:flutter/material.dart';

class SafeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  const SafeAppBar({Key key, this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 36),
      child: appBar,
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 92);
}
