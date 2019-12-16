import 'package:flutter/material.dart';
import 'package:nyaa_app/nyaa_item.dart';
import 'package:nyaa_app/nyaa_scraper.dart';

class NyaaItemsList extends StatefulWidget {
  final List<NyaaItem> items;

  NyaaItemsList({Key key, this.items}) : super(key: key);

  @override
  _NyaaItemsListState createState() => _NyaaItemsListState();
}

class _NyaaItemsListState extends State<NyaaItemsList> {
  Future<List<NyaaItem>> items;

  @override
  void initState() {
    super.initState();
    this.items = scrape();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NyaaItem>>(
      future: this.items,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              for(NyaaItem item in snapshot.data)
                NyaaItemCard(item: item)
            ],
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return Padding(
          padding: EdgeInsets.all(10),
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
