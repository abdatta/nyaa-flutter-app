import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nyaa_app/nyaa_item.dart';

class NyaaItemsList extends StatefulWidget {
  final Future<List<NyaaItem>> items;

  NyaaItemsList({Key key, this.items}) : super(key: key);

  @override
  _NyaaItemsListState createState() => _NyaaItemsListState();
}

class _NyaaItemsListState extends State<NyaaItemsList> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NyaaItem>>(
      future: widget.items,
      builder: (context, snapshot) {
        List<NyaaItem> items = snapshot.data;
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return NyaaItemCard(
                item: items[index],
              );
            },
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
