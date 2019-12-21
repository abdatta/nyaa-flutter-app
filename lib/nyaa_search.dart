
import 'package:flutter/material.dart';

class NyaaSearchBar extends StatelessWidget {
  final String search;
  final void Function(String) update;

  NyaaSearchBar({Key key, this.search, this.update}): super(key: key);

   @override
   Widget build(BuildContext context) {
     return TextField(
          cursorColor: Colors.white,
          autofocus: true,
          controller: TextEditingController(text: this.search),
          style: TextStyle(color: Colors.white, fontSize: 20),
          decoration: InputDecoration(
            focusColor: Colors.white,
            hoverColor: Colors.white,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white, fontSize: 20)
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: update
        );
   }
}