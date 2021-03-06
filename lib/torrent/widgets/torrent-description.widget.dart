import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class NyaaTorrentDescription extends StatelessWidget {
  final String description;

  NyaaTorrentDescription({Key key, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: ExpansionTile(
        title: Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: Icon(Icons.keyboard_arrow_down),
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: MarkdownBody(data: this.description, onTapLink: print),
          )
        ],
      ),
    );
  }
}