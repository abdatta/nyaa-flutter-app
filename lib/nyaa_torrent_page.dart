import 'package:flutter/material.dart';
import 'package:nyaa_app/nyaa_scraper.dart';
import 'package:nyaa_app/nyaa_torrent.dart';
import 'package:nyaa_app/nyaa_torrent_description.dart';

class NyaaTorrentPage extends StatelessWidget {
  final Future<NyaaTorrent> torrent;
  final String link;

  NyaaTorrentPage({Key key, this.link}) : torrent = fetchTorrent(link), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text('nyaa.si' + this.link),
          ),
          body: FutureBuilder<NyaaTorrent>(
            future: this.torrent,
            builder: (context, snapshot) {
              NyaaTorrent torrent = snapshot.data;
              if (!snapshot.hasData) {
                // Show a loading spinner untill data is fetched
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return ListView(
                children: <Widget>[
                  NyaaTorrentCard(torrent: torrent),
                  NyaaTorrentDescription(description: torrent.description)
                ],
              );
            }
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => print('refresh'),
            tooltip: 'Refresh',
            backgroundColor: Colors.orange,
            splashColor: Colors.orangeAccent,
            child: Icon(Icons.refresh),
          ),
        );
  }
}
