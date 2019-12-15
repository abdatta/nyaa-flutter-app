import 'package:flutter/material.dart';

class NyaaItem extends StatelessWidget{
  final category;
  final title;
  final size;
  final date;
  final comments;
  final seeders;
  final leechers;
  final downloaded;

  NyaaItem({Key key, this.category, this.title, this.size, this.date, this.comments, this.seeders, this.leechers, this.downloaded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  Text(this.title, style: TextStyle(fontSize: 17)),
                  Padding(
                    padding: EdgeInsets.fromLTRB(2, 6, 0, 0),
                    child: Wrap(
                      spacing: 6,
                      children: <Widget>[
                        Image.network('https://nyaa.si/static/img/icons/nyaa/' + this.category + '.png', height: 15),
                        Text('|'),
                        Text(this.size, style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('|'),
                        Text(this.date, style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  Wrap(
                    spacing: 5,
                    children: <Widget>[
                      if (this.comments > 0) NyaaItemStat(
                        icon: Icons.comment,
                        text: this.comments.toString(),
                        spacing: 2,
                      ),
                      NyaaItemStat(
                        icon: Icons.file_upload,
                        color: Colors.green,
                        text: this.seeders.toString()
                      ),
                      NyaaItemStat(
                        icon: Icons.file_download,
                        color: Colors.red,
                        text: this.leechers.toString()
                      ),
                      NyaaItemStat(
                        icon: Icons.offline_pin,
                        text: this.downloaded.toString(),
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
                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20.0) ),
                  child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20.0) ),
                    splashColor: Colors.blueAccent,
                    onPressed: () {
                      /*...*/
                      print('download torrent');
                    },
                    child: Icon(Icons.file_download),
                  )
                ),
                ButtonTheme(
                  minWidth: 40,
                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20.0) ),
                  child: FlatButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20.0) ),
                    splashColor: Colors.greenAccent,
                    onPressed: () {
                      /*...*/
                      print('copy magnet link');
                    },
                    child: Icon(Icons.attachment),
                  )
                )
              ],
            )
          ],
        )
      )
    );
  }

}

class NyaaItemStat extends StatelessWidget {
  final IconData icon;
  final MaterialColor color;
  final String text;
  final double spacing;

  NyaaItemStat({Key key, this.icon, this.color, this.text, this.spacing = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: CircleAvatar(
        backgroundColor: this.color,
        child: Icon(
          this.icon,
          color: Colors.white,
          size: 15
        ),
      ),
      label: Text(this.text, style: TextStyle(color: this.color)),
    );
  }
}
