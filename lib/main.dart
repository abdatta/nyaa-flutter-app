import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: MyHomePage(title: 'Nyaa.si'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            NyaaItem(),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      drawer: NyaaDrawer(tiles: ['Upload', 'Info', 'RSS', 'Twitter', 'Fap']),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NyaaDrawer extends StatelessWidget {

  final List<String> tiles;

  NyaaDrawer({Key key, this.tiles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Guest'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          for (String tile in this.tiles) ListTile(
            title: Text(tile),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}

class NyaaItem extends StatelessWidget{
  final category = 'Anime Subs';
  final title = '[YakuboEncodes] Detective Conan - 963 [1080p][10 bit][x265 HEVC][Opus][HorribleSubs].mkv';
  final size = '1.4 GiB';
  final date = '2019-12-14 18:10';
  final comments = 2;
  final seeders = 11;
  final leechers = 5;
  final downloaded = 61;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            trailing: Icon(Icons.file_download),
            title: Text(this.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(2, 6, 0, 0),
                  child: Wrap(
                    spacing: 6,
                    children: <Widget>[
                      Image.network('https://nyaa.si/static/img/icons/nyaa/1_2.png', height: 15),
                      Text('|'),
                      Text(this.size, style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('|'),
                      Text(this.date, style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                Wrap(
                  spacing: 5,
                  children: <Widget>[
                    if (this.comments > 0) NyaaItemStat(
                      icon: Icons.comment,
                      text: this.comments.toString(),
                      spacing: 2,
                    ),
                    NyaaItemStat(
                      icon: Icons.file_upload,
                      color: Colors.green,
                      text: this.seeders.toString()
                    ),
                    NyaaItemStat(
                      icon: Icons.file_download,
                      color: Colors.red,
                      text: this.leechers.toString()
                    ),
                    NyaaItemStat(
                      icon: Icons.offline_pin,
                      text: this.downloaded.toString(),
                      spacing: 2,
                    ),
                  ],
                )
              ],
            )
          ),
        ],
      ),
    );
  }

}

class NyaaItemStat extends StatelessWidget {
  final IconData icon;
  final MaterialColor color;
  final String text;
  final double spacing;

  NyaaItemStat({Key key, this.icon, this.color, this.text, this.spacing = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: CircleAvatar(
        backgroundColor: this.color,
        child: Icon(
          this.icon,
          color: Colors.white,
          size: 15
        ),
      ),
      label: Text(this.text, style: TextStyle(color: this.color)),
    );
  }
}
