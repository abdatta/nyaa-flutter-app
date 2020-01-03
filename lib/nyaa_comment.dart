import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:nyaa_app/nyaa_item.dart';

class NyaaComment {
  String user;
  NyaaItemType userType; // Todo: Find all user types and create a separate class for NyaaUserType
  String avatar;
  String date;
  String body;

  NyaaComment({this.user, this.userType, this.avatar, this.date, this.body});
}

class NyaaCommentsList extends StatelessWidget {
  final List<NyaaComment> comments;

  NyaaCommentsList({Key key, this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.all(10),
      child: ExpansionTile(
        title: Text('Comments (${comments.length})', style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: Icon(Icons.keyboard_arrow_down),
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                for(NyaaComment comment in this.comments)
                  NyaaCommentCard(comment: comment)
              ],
            )
          )
        ],
      ),
    );
  }
}

class NyaaCommentCard extends StatelessWidget {
  final NyaaComment comment;

  NyaaCommentCard({Key key, this.comment}) : super(key: key);

  String formatDate(String utc) {
    utc = utc.substring(0, utc.length-4) + 'Z';
    DateTime datetime = DateTime.parse(utc).toLocal();
    String date = DateFormat('yMd').format(datetime);
    String time = DateFormat('Hm').format(datetime);
    return '$date $time';
  }

  Color getTypeColor(NyaaItemType type) {
    switch (type) {
      case NyaaItemType.TRUSTED: return Colors.green;
      case NyaaItemType.REMAKE: return Colors.red;
      case NyaaItemType.BATCH: return Colors.orange;
      case NyaaItemType.NORMAL:
      default: return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                    imageUrl: comment.avatar,
                    placeholder: (context, url) => SizedBox(child: Center(child: Icon(Icons.image, color: Colors.grey, size: 40)), width: 120, height: 120),
                    errorWidget: (context, url, error) => SizedBox(child: Center(child: Icon(Icons.broken_image, color: Colors.grey, size: 40)), width: 120, height: 120),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            child: Text(this.comment.user, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: getTypeColor(this.comment.userType))),
                            onTap: () => Navigator.pushNamed(context, '/', arguments: this.comment.user),
                          ),
                          Text(formatDate(this.comment.date), style: TextStyle(fontWeight: FontWeight.w300))
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: MarkdownBody(
                          data: this.comment.body,
                          onTapLink: print,
                          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context).copyWith(textTheme: Theme.of(context).textTheme.copyWith(body1: Theme.of(context).textTheme.body1.copyWith(fontSize: 12)))))
                      )
                    ]
                  )
                )
              )
            ],
          ),
        ]
      ),
    );
  }
}