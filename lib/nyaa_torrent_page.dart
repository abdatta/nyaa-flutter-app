import 'package:flutter/material.dart';
import 'package:nyaa_app/nyaa_scraper.dart';
import 'package:nyaa_app/nyaa_torrent.dart';

class NyaaTorrentPage extends StatefulWidget {
  final String link;

  NyaaTorrentPage({Key key, this.link}) : super(key: key);

  @override
  _NyaaTorrentPageState createState() => _NyaaTorrentPageState();
}

class _NyaaTorrentPageState extends State<NyaaTorrentPage> {
  Future<NyaaTorrent> torrent;

  @override
  Widget build(BuildContext context) {
    this.torrent = fetchTorrent(widget.link);
    return FutureBuilder<NyaaTorrent>(
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

        return Scaffold(
          appBar: AppBar(
            title: Text(torrent.title),
          ),
          body: NyaaTorrentCard(torrent: torrent),
          floatingActionButton: FloatingActionButton(
            onPressed: () => print('refresh'),
            tooltip: 'Refresh',
            backgroundColor: Colors.orange,
            splashColor: Colors.orangeAccent,
            child: Icon(Icons.refresh),
          ),
        );
      });
  }
}