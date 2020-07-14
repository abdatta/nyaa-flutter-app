import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nyaa_app/search/models/item.model.dart';
import 'package:nyaa_app/search/models/search-args.model.dart';
import 'package:nyaa_app/search/models/search-data.model.dart';
import 'package:nyaa_app/search/widgets/item-card.widget.dart';

class NyaaItemsPage extends StatefulWidget {
  final Future<SearchPageData> data;

  NyaaItemsPage({Key key, this.data}) : super(key: key);

  @override
  _NyaaItemsPageState createState() => _NyaaItemsPageState();
}

class _NyaaItemsPageState extends State<NyaaItemsPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SearchPageData>(
      future: widget.data,
      builder: (context, snapshot) {
        SearchPageData data = snapshot.data;
        if (snapshot.hasData) {
          return Column(children: [
            if (data.alert != null)
              Card(
                  color: Colors.blueAccent,
                  child: Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () => Navigator.pushNamed(context, '/',
                                    arguments: SearchArgs(user: data.alert)),
                                child: Text(
                                    'See only results uploaded by ' +
                                        data.alert,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)))
                          ]))),
            Expanded(child: NyaaItemsList(items: data.items))
          ]);
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

class NyaaItemsList extends StatelessWidget {
  final List<NyaaItem> items;

  NyaaItemsList({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.items.length,
      itemBuilder: (context, index) {
        return NyaaItemCard(
          item: this.items[index],
        );
      },
    );
  }
}
