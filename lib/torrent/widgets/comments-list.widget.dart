import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nyaa_app/torrent/models/comment.model.dart';
import 'package:nyaa_app/torrent/widgets/comment-card.widget.dart';

class NyaaCommentsList extends StatelessWidget {
  final List<NyaaComment> comments;

  NyaaCommentsList({Key key, this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.all(10),
      child: ExpansionTile(
        title: Text('Comments (${comments.length})',
            style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: Icon(Icons.keyboard_arrow_down),
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  for (NyaaComment comment in this.comments)
                    NyaaCommentCard(comment: comment)
                ],
              ))
        ],
      ),
    );
  }
}
