import 'package:nyaa_app/search/models/item.model.dart';

class SearchPageData {
  final List<NyaaItem> items;
  final String alert;
  SearchPageData(this.items, [this.alert]);
}
