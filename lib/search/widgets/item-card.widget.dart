import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nyaa_app/search/models/item.model.dart';
import 'package:nyaa_app/search/widgets/item-stat.widget.dart';
import 'package:nyaa_app/shared/models/item-type.model.dart';

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
