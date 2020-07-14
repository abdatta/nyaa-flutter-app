import 'package:flutter/material.dart';
import 'package:nyaa_app/shared/models/item-type.model.dart';

class NyaaItem {
  final NyaaItemType type;
  final String category;
  final String title;
  final String titleLink;
  final String size;
  final DateTime date;
  final int comments;
  final int seeders;
  final int leechers;
  final int downloaded;

  NyaaItem(
      {Key key,
      this.type,
      this.category,
      this.title,
      this.titleLink,
      this.size,
      this.date,
      this.comments,
      this.seeders,
      this.leechers,
      this.downloaded});
}
