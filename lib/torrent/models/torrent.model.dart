import 'package:nyaa_app/shared/models/item-type.model.dart';
import 'package:nyaa_app/torrent/models/comment.model.dart';
import 'package:nyaa_app/torrent/models/file.model.dart';

class NyaaTorrent {
  final NyaaItemType type;
  final String title;
  final List<List<String>> metadata;
  final String description;
  final List<NyaaTorrentFile> files;
  final List<NyaaComment> comments;

  NyaaTorrent(
      {this.type,
      this.title,
      this.metadata,
      this.description,
      this.files,
      this.comments});
}
