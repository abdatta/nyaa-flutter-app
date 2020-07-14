import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NyaaItemStat extends StatelessWidget {
  final IconData icon;
  final MaterialColor color;
  final String text;
  final double spacing;

  NyaaItemStat({Key key, this.icon, this.color, this.text, this.spacing = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Colors.transparent,
      avatar: CircleAvatar(
        backgroundColor: this.color,
        child: Icon(this.icon, color: Colors.white, size: 15),
      ),
      label: Text(this.text, style: TextStyle(color: this.color)),
    );
  }
}
