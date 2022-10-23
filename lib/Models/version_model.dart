class Version {
  String version;
  bool isObligatory;
  String url;

  Version({
    required this.version,
    required this.isObligatory,
    required this.url,
  });

  factory Version.fromJson(Map<String, dynamic> json) {
    return Version(
      version: json['version'],
      isObligatory: json['isObligatory'],
      url: json['url'],
    );
  }
}
