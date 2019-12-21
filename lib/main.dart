import 'package:flutter/material.dart';
import 'package:nyaa_app/nyaa_drawer.dart';
import 'package:nyaa_app/nyaa_item.dart';
import 'package:nyaa_app/nyaa_items_list.dart';
import 'package:nyaa_app/nyaa_popup_menu.dart';
import 'package:nyaa_app/nyaa_scraper.dart';
import 'package:nyaa_app/nyaa_search.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nyaa App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'Nyaa')
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<NyaaItem>> items;
  String query;
  bool loading = false;
  bool searching = false;

  /* Note: This function doesn't update the state though */
  void update(String newQuery) {
    newQuery = newQuery.trim();
    if (newQuery != this.query){
      this.query = newQuery;
      this.items = scrape(this.query);
    }
  }

  void refresh() {
    setState(() {
      this.loading = true;
      this.items = scrape(this.query);
      this.items.whenComplete(() {
        setState(() {
          this.loading = false;
        });
      });
    });
  }

  void search(String query) {
    this.searching = false;
    if (query.trim() == this.query) return;
    Navigator.pushNamed(context, '/', arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    update(ModalRoute.of(context).settings.arguments ?? '');
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: this.searching ?
          NyaaSearchBar(search: this.query, update: this.search) :
          Text(widget.title + (this.query != '' ? ' :: ' + this.query : '')),
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
        child: (this.loading) ? CircularProgressIndicator() : NyaaItemsList(items: this.items)
      ),
      drawer: NyaaDrawer(tiles: ['Upload', 'Info', 'RSS', 'Twitter', 'Fap']),
      floatingActionButton: FloatingActionButton(
        onPressed: refresh,
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
