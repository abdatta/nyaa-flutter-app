import 'package:flutter/material.dart';

class NyaaDrawer extends StatelessWidget {

  final List<String> tiles;

  NyaaDrawer({Key key, this.tiles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Guest'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          for (String tile in this.tiles) ListTile(
            title: Text(tile),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
