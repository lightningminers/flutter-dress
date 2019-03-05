class PhotoDir {
  final String name;
  final String type;
  final String url;
  bool collections;

  PhotoDir(this.name, this.type, this.url, this.collections);
  PhotoDir.fromJSON(Map<String, dynamic> json)
    : name = json['name'],
      type = json['type'],
      url = json['url'],
      collections = false;
}
