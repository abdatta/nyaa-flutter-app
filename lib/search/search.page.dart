import 'package:flutter/material.dart';
import 'package:nyaa_app/search/models/search-data.model.dart';
import 'package:nyaa_app/search/search.service.dart';
import 'package:nyaa_app/search/models/search-args.model.dart';
import 'package:nyaa_app/search/widgets/drawer.widget.dart';
import 'package:nyaa_app/search/widgets/items-list.widget.dart';
import 'package:nyaa_app/search/widgets/popup-menu.widget.dart';
import 'package:nyaa_app/search/widgets/search-bar.widget.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<SearchPageData> itemsPageData;
  String query;
  String user;
  bool loading = false;
  bool searching = false;

  /* Note: This function doesn't update the state though */
  void update(String newQuery, String user) {
    newQuery = newQuery.trim();
    if (newQuery == this.query && user == this.user) return;

    this.query = newQuery;
    this.user = user;
    print("Searching for user: " + user);
    this.itemsPageData = fetchItemsPage(this.query, this.user);
  }

  void refresh() {
    setState(() {
      this.loading = true;
      this.itemsPageData = fetchItemsPage(this.query, this.user);
      this.itemsPageData.whenComplete(() {
        setState(() {
          this.loading = false;
        });
      });
    });
  }

  void search(String query, String user) {
    setState(() {
      this.searching = false;
    });
    if (query.trim() == this.query && user == this.user) return;

    this.user = user;
    Navigator.pushNamed(context, '/',
        arguments: SearchArgs(query: query, user: user));
  }

  @override
  Widget build(BuildContext context) {
    SearchArgs args = ModalRoute.of(context).settings.arguments ?? SearchArgs();
    update(args.query, args.user);
    return Scaffold(
      appBar: AppBar(
        title: this.searching
            ? NyaaSearchBar(
                search: this.query, user: this.user, update: this.search)
            : Text((this.user == '' ? widget.title : this.user) +
                (this.query != '' ? ' :: ' + this.query : '')),
        actions: <Widget>[
          IconButton(
            icon: Icon(this.searching ? Icons.clear : Icons.search),
            tooltip: 'Search',
            onPressed: () {
              setState(() {
                print('Search');
                this.searching = !this.searching;
              });
            },
          ),
          NyaaPopupMenu()
        ],
      ),
      body: Center(
          child: (this.loading)
              ? CircularProgressIndicator()
              : NyaaItemsPage(data: this.itemsPageData)),
      drawer: NyaaDrawer(tiles: ['Upload', 'Info', 'RSS', 'Twitter', 'Fap']),
      floatingActionButton: FloatingActionButton(
        onPressed: refresh,
        tooltip: 'Refresh',
        backgroundColor: Colors.orange,
        splashColor: Colors.orangeAccent,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
