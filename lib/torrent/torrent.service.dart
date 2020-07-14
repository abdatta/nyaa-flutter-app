import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:nyaa_app/shared/models/item-type.model.dart';
import 'package:nyaa_app/shared/scraper.service.dart';
import 'package:nyaa_app/torrent/models/comment.model.dart';
import 'package:nyaa_app/torrent/models/file.model.dart';
import 'package:nyaa_app/torrent/models/torrent.model.dart';

NyaaComment extractComment(Element elem) {
  Document doc = toDoc(elem);
  Element userElement = doc.querySelector('.panel-body > .col-md-2 > p > a');
  Element avatarElement =
      doc.querySelector('.panel-body > .col-md-2 > img.avatar');
  Element dateElement = doc
      .querySelector('.panel-body > .comment > .comment-details > a > small');
  Element bodyElement = doc.querySelector(
      '.panel-body > .comment > .comment-body > .comment-content');

  return NyaaComment(
      user: userElement.text.trim(),
      userType: getNyaaItemType(userElement.className.trim()),
      avatar: avatarElement.attributes['src'],
      date: dateElement.text.trim(),
      body: bodyElement.text.trim());
}

List<NyaaTorrentFile> extractFilesList(Element elem) {
  return elem.children.map((fileElement) {
    String typeClass = toDoc(fileElement).querySelector('i').className;
    return typeClass.contains('folder')
        ? NyaaTorrentFile(
            isFolder: true,
            name: fileElement.children[0].text.trim(),
            subfiles: extractFilesList(fileElement.children[1]))
        : NyaaTorrentFile(
            name: fileElement.text.trim(),
          );
  }).toList();
}

NyaaTorrent extractTorrent(String body) {
  Document document = parse(body);

  Element panelElement = document.querySelector('.panel');
  Element titleElement =
      document.querySelector('.panel > .panel-heading > .panel-title');

  List<Element> infoKeysElements =
      document.querySelectorAll('.panel > .panel-body > .row > .col-md-1');
  List<Element> infoDataElements =
      document.querySelectorAll('.panel > .panel-body > .row > .col-md-5');
  List<List<String>> infos = [];
  for (int i = 0; i < infoKeysElements.length; i++)
    infos.add(
        [infoKeysElements[i].text.trim(), infoDataElements[i].text.trim()]);

  Element descriptionElement = document.querySelector('#torrent-description');
  List<Element> commentsElements =
      document.querySelectorAll('div.comment-panel[id^=com-]');

  return NyaaTorrent(
      type: getNyaaItemType(panelElement.className),
      title: titleElement.text.trim(),
      metadata: infos,
      description: descriptionElement.text.trim(),
      files:
          extractFilesList(document.querySelector('.torrent-file-list > ul')),
      comments: commentsElements
          .map<NyaaComment>((Element elem) => extractComment(elem))
          .toList());
}

Future<NyaaTorrent> fetchTorrent(String url) async {
  url = NYAA_URL + url.trim();
  print('Fetching: ' + url);
  Response response = await Client().get(url);
  return extractTorrent(response.body);
}
