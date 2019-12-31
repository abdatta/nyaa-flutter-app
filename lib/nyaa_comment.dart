import 'package:flutter/material.dart';

class NyaaComment {
  String user;
  String avatar;
  String date;
  String body;

  NyaaComment({this.user, this.avatar, this.date, this.body});
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
        title: Container(
          child: Text('Comments (${comments.length})', style: TextStyle(fontWeight: FontWeight.bold))
        ),
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
                child: Image.network(this.comment.avatar)
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(this.comment.user, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                          Text(this.comment.date, style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(this.comment.body)
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