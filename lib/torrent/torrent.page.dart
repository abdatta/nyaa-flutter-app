import 'package:flutter/material.dart';
import 'package:nyaa_app/torrent/models/torrent.model.dart';
import 'package:nyaa_app/torrent/widgets/torrent-card.widget.dart';
import 'package:nyaa_app/torrent/widgets/torrent-description.widget.dart';
import 'package:nyaa_app/torrent/widgets/torrent-files-list.widget.dart';
import 'package:nyaa_app/torrent/widgets/comments-list.widget.dart';
import 'package:nyaa_app/torrent/torrent.service.dart';

class NyaaTorrentPage extends StatelessWidget {
  final String link;

  NyaaTorrentPage({Key key, this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('nyaa.si' + this.link),
        ),
        body: FutureBuilder<NyaaTorrent>(
            future: fetchTorrent(link),
            builder: (context, snapshot) {
              NyaaTorrent torrent = snapshot.data;
              if (!snapshot.hasData) {
                // Show a loading spinner untill data is fetched
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return ListView(
                children: <Widget>[
                  NyaaTorrentCard(torrent: torrent),
                  NyaaTorrentDescription(description: torrent.description),
                  NyaaTorrentFilesList(files: torrent.files),
                  NyaaCommentsList(comments: torrent.comments)
                ],
              );
            }));
  }
}
