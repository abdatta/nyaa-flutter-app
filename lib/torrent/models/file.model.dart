class NyaaTorrentFile {
  final String name;
  final bool isFolder;
  final List<NyaaTorrentFile> subfiles;

  NyaaTorrentFile({this.name, this.isFolder = false, this.subfiles = const []});

  @override
  String toString({int depth = 0}) {
    String ind = List.generate(depth, (i) => '  ').join('');
    String res = '\n$ind[\n' +
        subfiles.map((f) => f.toString(depth: depth + 1)).toList().join('\n') +
        '\n$ind]';
    return '$ind$name' + (isFolder ? res : '');
  }
}
