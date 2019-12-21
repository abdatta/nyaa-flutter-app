
import 'package:flutter/material.dart';

class NyaaPopupMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String result) { print(result); },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        nyaaPopupMenuItem(value: 'profile', icon: Icons.account_circle, text: 'Profile'),
        nyaaPopupMenuItem(value: 'torrents', icon: Icons.cloud_upload, text: 'Torrents'),
        nyaaPopupMenuItem(value: 'dark_mode', icon: Icons.brightness_4, text: 'Dark Mode'),
        nyaaPopupMenuItem(value: 'logout', icon: Icons.exit_to_app, text: 'Logout')
      ],
    );
  }

  PopupMenuItem<String> nyaaPopupMenuItem({String value, String text, IconData icon}) {
    return PopupMenuItem<String>(
      value: value,
      child: Wrap(
        spacing: 8,
        children: <Widget>[Icon(icon, size: 18), Text(text)]
      ),
    );
  }
}