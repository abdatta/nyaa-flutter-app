import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:nyaa_app/search/models/item.model.dart';
import 'package:nyaa_app/search/models/search-data.model.dart';
import 'package:nyaa_app/shared/models/item-type.model.dart';
import 'package:nyaa_app/shared/scraper.service.dart';

const String NYAA_URL = 'https://nyaa.si';

Future<SearchPageData> fetchItemsPage(String query, String user) async {
  String url = NYAA_URL + (user == '' ? '/' : '/user/' + user);
  if (query.trim() != '') {
    url += '?f=0&c=0_0&q=' + Uri.encodeComponent(query);
  }
  print('Fetching: ' + url);
  Response response = await Client().get(url);
  return SearchPageData(
      extractItems(response.body), extractSuggestedUser(response.body));
}

String extractSuggestedUser(String body) {
  var document = parse(body);
  Element alerts =
      document.querySelector('div.alert.alert-info > a[href^="/user/"]');
  return alerts?.attributes != null
      ? alerts?.attributes['href'].split('/').last.split('?').first
      : null;
}

List<NyaaItem> extractItems(String body) {
  var document = parse(body);
  List<Element> items =
      document.querySelectorAll('table.torrent-list > tbody > tr');
  print('Found: ' + items.length.toString() + ' items');
  List<NyaaItem> nyaaitems = [];
  for (Element item in items) {
    List<Element> props = toDoc(item).querySelectorAll('pd');
    var nyaaitem = NyaaItem(
      type: getNyaaItemType(item.className.trim()),
      category:
          toDoc(props[0]).querySelector('a').attributes['href'].substring(4),
      title: toDoc(props[1]).querySelectorAll('a').last.text,
      titleLink: toDoc(props[1]).querySelectorAll('a').last.attributes['href'],
      comments: int.tryParse(toDoc(props[1]).querySelector('a.comments') == null
              ? '0'
              : toDoc(props[1]).querySelector('a.comments').text.trim()) ??
          -1,
      size: props[3].text,
      date: DateTime.parse(props[4].text.trim() + 'Z').toLocal(),
      seeders: int.tryParse(props[5].text.trim()) ?? -1,
      leechers: int.tryParse(props[6].text.trim()) ?? -1,
      downloaded: int.tryParse(props[7].text.trim()) ?? -1,
    );
    nyaaitems.add(nyaaitem);
  }
  return nyaaitems;
}
