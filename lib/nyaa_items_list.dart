import 'package:flutter/material.dart';
import 'package:nyaa_app/nyaa_item.dart';

class NyaaItemsList extends StatelessWidget {
  final List<NyaaItem> items;

  NyaaItemsList({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for(NyaaItem item in this.items)
          NyaaItemCard(item: item)
      ],
    );
  }
}
