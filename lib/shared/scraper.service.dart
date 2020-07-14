import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart'; // Contains DOM related classes for extracting data from elements

const String NYAA_URL = 'https://nyaa.si';

Document toDoc(Element elem) {
  var text = elem.innerHtml.replaceAll('<td', '<pd').replaceAll('</td', '</pd');
  return parse(text);
}
