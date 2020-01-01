import 'package:flutter/foundation.dart';
import 'package:http/http.dart'; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart'; // Contains DOM related classes for extracting data from elements
import 'package:nyaa_app/nyaa_comment.dart';
import 'package:nyaa_app/nyaa_item.dart';
import 'package:nyaa_app/nyaa_torrent.dart';

const String NYAA_URL = 'https://nyaa.si';

Document toDoc(Element elem) {
  var text = elem.innerHtml.replaceAll('<td', '<pd').replaceAll('</td', '</pd');
  return parse(text);
}

NyaaItemType getNyaaItemType(String type) {
  if (type.contains('success'))
    return NyaaItemType.TRUSTED;
  else if (type.contains('danger'))
    return NyaaItemType.REMAKE;
  else if (type.contains('warning'))
    return NyaaItemType.BATCH;
  else
    return NyaaItemType.NORMAL;
}

List<NyaaItem> extractItems(String body) {
  var document = parse(body);
  List<Element> items = document.querySelectorAll('table.torrent-list > tbody > tr');
  print('Found: ' + items.length.toString() + ' items');
  List<NyaaItem> nyaaitems = [];
  for(Element item in items) {
    List<Element> props = toDoc(item).querySelectorAll('pd');
    var nyaaitem = NyaaItem(
      type: getNyaaItemType(item.className.trim()),
      category: toDoc(props[0]).querySelector('a').attributes['href'].substring(4),
      title: toDoc(props[1]).querySelectorAll('a').last.text,
      titleLink: toDoc(props[1]).querySelectorAll('a').last.attributes['href'],
      comments: int.tryParse(toDoc(props[1]).querySelector('a.comments') == null ? '0' : toDoc(props[1]).querySelector('a.comments').text.trim()) ?? -1,
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

Future<List<NyaaItem>> fetchItems(String query) async {
  String url = NYAA_URL;
  if (query.trim() != '') {
    url += '/?f=0&c=0_0&q=' + Uri.encodeComponent(query);
  }
  print('Fetching: ' + url);
  Response response = await Client().get(url);
  return extractItems(response.body);
}

NyaaComment extractComment(Element elem) {
  Document doc = toDoc(elem);
  Element userElement = doc.querySelector('.panel-body > .col-md-2 > p > a');
  Element avatarElement = doc.querySelector('.panel-body > .col-md-2 > img.avatar');
  Element dateElement = doc.querySelector('.panel-body > .comment > .comment-details > a > small');
  Element bodyElement = doc.querySelector('.panel-body > .comment > .comment-body > .comment-content');

  return NyaaComment(
    user: userElement.text.trim(),
    avatar: avatarElement.attributes['src'],
    date: dateElement.text.trim(),
    body: bodyElement.text.trim()
  );
}

class NyaaTorrentFile {
  final String type; // 'file' or 'folder'
  final String name;
  final List<NyaaTorrentFile> subfiles;

  NyaaTorrentFile({@required this.type, @required this.name, this.subfiles = const []});

  @override
  String toString({int depth = 0}) {
    String ind = List.generate(depth, (i) => '  ').join('');
    String res ='\n$ind[\n' + subfiles.map((f) => f.toString(depth: depth + 1)).toList().join('\n') + '\n$ind]';
    return '$ind$type :: $name' + (type == 'folder' ? res : '');
  }
}

List<NyaaTorrentFile> extractFilesList(Element elem) {
  return elem.children.map((fileElement) {
    String typeClass = toDoc(fileElement).querySelector('i').className;
    return typeClass.contains('folder') ? NyaaTorrentFile(
      type: 'folder',
      name: fileElement.children[0].text.trim(),
      subfiles: extractFilesList(fileElement.children[1])
    ): NyaaTorrentFile(
      type: 'file',
      name: fileElement.text.trim(),
    );
  }).toList();
}

NyaaTorrent extractTorrent(String body) {
  Document document = parse(body);

  Element panelElement = document.querySelector('.panel');
  Element titleElement = document.querySelector('.panel > .panel-heading > .panel-title');

  List<Element> infoKeysElements = document.querySelectorAll('.panel > .panel-body > .row > .col-md-1');
  List<Element> infoDataElements = document.querySelectorAll('.panel > .panel-body > .row > .col-md-5');
  List<List<String>> infos = [];
  for (int i=0; i<infoKeysElements.length; i++)
    infos.add([infoKeysElements[i].text.trim(), infoDataElements[i].text.trim()]);

  Element descriptionElement = document.querySelector('#torrent-description');
  List<Element> commentsElements = document.querySelectorAll('div.comment-panel[id^=com-]');

  return NyaaTorrent(
    type: getNyaaItemType(panelElement.className),
    title: titleElement.text.trim(),
    metadata: infos,
    description: descriptionElement.text.trim(),
    files: extractFilesList(document.querySelector('.torrent-file-list > ul')),
    comments: commentsElements.map<NyaaComment>((Element elem) => extractComment(elem)).toList()
  );
}

Future<NyaaTorrent> fetchTorrent(String url) async {
  url = NYAA_URL + url.trim();
  print('Fetching: ' + url);
  Response response = await Client().get(url);
  return extractTorrent(response.body);
}
