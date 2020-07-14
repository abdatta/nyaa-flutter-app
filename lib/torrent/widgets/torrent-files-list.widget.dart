import 'package:flutter/material.dart';
import 'package:nyaa_app/torrent/models/file.model.dart';

class NyaaTorrentFilesList extends StatelessWidget {
  final List<NyaaTorrentFile> files;

  NyaaTorrentFilesList({Key key, this.files}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: ExpansionTile(
          title:
              Text('Files List', style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: Icon(Icons.keyboard_arrow_down),
          children: buildFilesList(this.files)),
    );
  }

  List<Widget> buildFilesList(List<NyaaTorrentFile> files) {
    return files.map((file) {
      // for a folder, return a recursively nested expansion tile
      if (file.isFolder) {
        return ExpansionTile(
          title: Row(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.folder, color: Colors.black54),
            ),
            Flexible(child: Text(file.name, style: TextStyle(fontSize: 14)))
          ]),
          children: this
              .buildFilesList(file.subfiles)
              .map((w) => Padding(padding: EdgeInsets.only(left: 15), child: w))
              .toList(),
        );
      }
      // if not a folder, return just a tile
      else {
        return ListTile(
          title: Row(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.insert_drive_file, color: Colors.black54),
            ),
            Flexible(
                child: RichText(
                    text: TextSpan(
                        text:
                            file.name.substring(0, file.name.lastIndexOf('(')),
                        style: TextStyle(fontSize: 12, color: Colors.black),
                        children: <TextSpan>[
                  TextSpan(
                      text: file.name.substring(
                          file.name.lastIndexOf('('), file.name.length),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey))
                ])))
          ]),
        );
      }
    }).toList();
  }
}
