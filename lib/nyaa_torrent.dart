import 'package:flutter/material.dart';
import 'package:nyaa_app/nyaa_comment.dart';
import 'package:nyaa_app/nyaa_item.dart';

class NyaaTorrent {
  final NyaaItemType type;
  final String title;
  final List<List<String>> metadata;
  final String description;
  final List<NyaaComment> comments;

  NyaaTorrent({this.type, this.title, this.metadata, this.description, this.comments});
}

class NyaaTorrentCard extends StatelessWidget {
  final NyaaTorrent torrent;

  NyaaTorrentCard({Key key, this.torrent}): super(key: key);

  Color getTypeColor(NyaaItemType type) {
    switch (type) {
      case NyaaItemType.TRUSTED: return Color(0xFFdff0d8); // Bootstrap's success color
      case NyaaItemType.REMAKE: return Color(0xFFf2dede); // Bootstrap's danger color
      case NyaaItemType.BATCH: return Color(0xFFfcf8e3); // Bootstrap's warning color
      case NyaaItemType.NORMAL:
      default: return Colors.grey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              color: this.getTypeColor(this.torrent.type),
              child: Text(torrent.title, style: TextStyle(fontSize: 18))
            ),
            Container(
              margin: EdgeInsets.fromLTRB(4, 10, 4, 10),
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(5),
              ),
              child: Column(
                children: <Widget>[
                  for(var md in this.torrent.metadata) Row(
                    children: <Widget>[
                      Container(
                        width: 90,
                        margin: EdgeInsets.fromLTRB(4, 5, 0, 5),
                        decoration: new BoxDecoration(
                          color: Colors.orange.shade200,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5)
                          )
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(6, 6, 0, 6),
                          child: Text(md[0], style: TextStyle(fontSize: 15))
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(4, 5, 4, 5),
                          decoration: new BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5)
                            )
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(4, 6, 6, 6),
                            child: Text(md[1], style: TextStyle(fontSize: 15))
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              color: Colors.blue.shade50,
              child: Wrap(
                spacing: 10,
                children: <Widget>[
                  FlatButton.icon(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blueAccent,
                    icon: Icon(Icons.file_download),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    onPressed: () => print('Torrent'),
                    label: Text('Torrent', style: TextStyle(fontSize: 15))
                  ),
                  FlatButton.icon(
                    color: Colors.green,
                    textColor: Colors.white,
                    splashColor: Colors.greenAccent,
                    icon: Icon(Icons.attachment),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    onPressed: () => print('Magnet'),
                    label: Text('Magnet', style: TextStyle(fontSize: 15))
                  )
                ],
              )
            )
          ],
        )
      ),
    );
  }
}
