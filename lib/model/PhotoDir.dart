class PhotoDir {
  final String name;
  final String type;
  final String url;

  PhotoDir(this.name, this.type, this.url);
  PhotoDir.fromJSON(Map<String, dynamic> json)
    : name = json['name'],
      type = json['type'],
      url = json['url'];
}