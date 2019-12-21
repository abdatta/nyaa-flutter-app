import 'package:http/http.dart'; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart'; // Contains DOM related classes for extracting data from elements
import 'package:nyaa_app/nyaa_item.dart';

const String NYAA_URL = 'https://nyaa.si/';

Document toDoc(Element elem) {
  var text = elem.innerHtml.replaceAll('<td', '<pd').replaceAll('</td', '</pd');
  return parse(text);
}

List<NyaaItem> fetchItems(String body) {
  var document = parse(body);
  List<Element> items = document.querySelectorAll('table.torrent-list > tbody > tr');
  print('Found: ' + items.length.toString() + ' items');
  List<NyaaItem> nyaaitems = [];
  for(Element item in items) {
    List<Element> props = toDoc(item).querySelectorAll('pd');
    var nyaaitem = NyaaItem(
      category: toDoc(props[0]).querySelector('a').attributes['href'].substring(4),
      title: toDoc(props[1]).querySelectorAll('a').last.text,
      comments: int.tryParse(toDoc(props[1]).querySelector('a.comments') == null ? '0' : toDoc(props[1]).querySelector('a.comments').text.trim()) ?? -1,
      size: props[3].text,
      date: props[4].text,
      seeders: int.tryParse(props[5].text.trim()) ?? -1,
      leechers: int.tryParse(props[6].text.trim()) ?? -1,
      downloaded: int.tryParse(props[7].text.trim()) ?? -1,
    );
    nyaaitems.add(nyaaitem);
  }
  return nyaaitems;
}

Future<List<NyaaItem>> scrape(String query) async {
  String url = NYAA_URL;
  if (query.trim() != '') {
    url += '?f=0&c=0_0&q=' + Uri.encodeComponent(query);
  }
  print('Fetching: ' + url);
  Response response = await Client().get(url);
  return fetchItems(response.body);
}
