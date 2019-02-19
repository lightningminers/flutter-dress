class Photo {
  final String name;
  final String sha;
  final String imageURL;

  Photo(this.name, this.sha, this.imageURL);
  Photo.fromJSON(Map<String, dynamic> json)
    : name = json['name'],
    sha = json['sha'],
    imageURL = json['download_url'];
}