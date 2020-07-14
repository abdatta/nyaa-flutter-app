
import 'package:flutter/material.dart';

class NyaaSearchBar extends StatefulWidget {
  final String search;
  final String user;
  final void Function(String, String) update;

  NyaaSearchBar({Key key, this.search, this.user, this.update}): super(key: key);

  @override
  _NyaaSearchBarState createState() => _NyaaSearchBarState(user: this.user);
}

class _NyaaSearchBarState extends State<NyaaSearchBar> {

  String user;

  _NyaaSearchBarState({this.user}): super();

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: widget.search);
    controller.selection = TextSelection(baseOffset: 0, extentOffset: widget.search.length);
    return TextField(
        cursorColor: Colors.white,
        enableSuggestions: true,
        autofocus: true,
        controller: controller,
        style: TextStyle(color: Colors.white, fontSize: 20),
        decoration: InputDecoration(
          prefixIcon: this.user == '' ? null : Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
            child: InputChip(
              label: Text(this.user),
              onDeleted: () => setState(() {
                this.user = '';
              })
            ),
          ),
          focusColor: Colors.white,
          hoverColor: Colors.white,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.white, fontSize: 20)
        ),
        textInputAction: TextInputAction.search,
        onSubmitted: (text) => widget.update(text, this.user)
      );
   }
}
