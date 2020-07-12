import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum NyaaItemType { NORMAL, TRUSTED, REMAKE, BATCH }

class NyaaItem {
  final NyaaItemType type;
  final String category;
  final String title;
  final String titleLink;
  final String size;
  final DateTime date;
  final int comments;
  final int seeders;
  final int leechers;
  final int downloaded;

  NyaaItem(
      {Key key,
      this.type,
      this.category,
      this.title,
      this.titleLink,
      this.size,
      this.date,
      this.comments,
      this.seeders,
      this.leechers,
      this.downloaded});
}

class NyaaItemCard extends StatelessWidget {
  final NyaaItem item;

  NyaaItemCard({Key key, this.item}) : super(key: key);

  String formatDate(DateTime datetime) {
    String date = DateFormat('yMMMd').format(datetime);
    String time = DateFormat('Hm').format(datetime);
    return '$date $time';
  }

  Color getTypeColor(NyaaItemType type) {
    switch (type) {
      case NyaaItemType.TRUSTED:
        return Color(0xFFdff0d8); // Bootstrap's success color
      case NyaaItemType.REMAKE:
        return Color(0xFFf2dede); // Bootstrap's danger color
      case NyaaItemType.BATCH:
        return Color(0xFFfcf8e3); // Bootstrap's warning color
      case NyaaItemType.NORMAL:
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: getTypeColor(this.item.type),
        child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (Widget child in [
                        Text(this.item.title, style: TextStyle(fontSize: 16)),
                        Padding(
                          padding: EdgeInsets.fromLTRB(2, 6, 0, 0),
                          child: Wrap(
                            spacing: 6,
                            children: <Widget>[
                              Image.network(
                                  'https://nyaa.si/static/img/icons/nyaa/' +
                                      this.item.category +
                                      '.png',
                                  height: 15),
                              Text('|'),
                              Text(this.item.size,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text('|'),
                              Text(formatDate(this.item.date),
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ],
                          ),
                        )
                      ])
                        GestureDetector(
                          child: child,
                          onTap: () => Navigator.pushNamed(context, '/view',
                              arguments: this.item.titleLink),
                        ),
                      Row(
                        children: <Widget>[
                          Wrap(
                            spacing: 5,
                            children: <Widget>[
                              NyaaItemStat(
                                  icon: Icons.file_upload,
                                  color: Colors.green,
                                  text: this.item.seeders.toString()),
                              NyaaItemStat(
                                  icon: Icons.file_download,
                                  color: Colors.red,
                                  text: this.item.leechers.toString()),
                              NyaaItemStat(
                                icon: Icons.offline_pin,
                                text: this.item.downloaded.toString(),
                                spacing: 2,
                              ),
                            ],
                          ),
                          Spacer(),
                          if (this.item.comments > 0)
                            NyaaItemStat(
                              icon: Icons.comment,
                              text: this.item.comments.toString(),
                              spacing: 2,
                            ),
                        ],
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ButtonTheme(
                        minWidth: 40,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: FlatButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          splashColor: Colors.blueAccent,
                          onPressed: () {
                            /*...*/
                            print('download torrent');
                          },
                          child: Icon(Icons.file_download),
                        )),
                    ButtonTheme(
                        minWidth: 40,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: FlatButton(
                          color: Colors.green,
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          splashColor: Colors.greenAccent,
                          onPressed: () {
                            /*...*/
                            print('copy magnet link');
                          },
                          child: Icon(Icons.attachment),
                        ))
                  ],
                )
              ],
            )));
  }
}

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
