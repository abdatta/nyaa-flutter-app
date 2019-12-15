import 'package:flutter/material.dart';
import 'package:nyaa_app/nyaa_item.dart';

class NyaaItemsList extends StatelessWidget {
  final List<NyaaItem> items = [
    NyaaItem(
      category: '1_2',
      title: '[YakuboEncodes] Detective Conan - 963 [1080p][10 bit][x265 HEVC][Opus][HorribleSubs].mkv',
      size: '120.0 MiB',
      date: '2019-12-14 18:10',
      comments: 2,
      seeders: 11,
      leechers: 5,
      downloaded: 61,
    ),
    NyaaItem(
      category: '1_4',
      title: '[SOFCJ-Raws] Detective Conan - The Scarlet School Trip [927-928] (BDRip 1280x720 x264 10bit FLAC).mkv',
      size: '2.1 GiB',
      date: '2019-12-15 10:17',
      comments: 0,
      seeders: 15,
      leechers: 10,
      downloaded: 30,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: this.items,
    );
  }
}