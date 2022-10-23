class HomeRecentlyAddedModel {
  int id;
  String name;
  String commerialAttachment;


  HomeRecentlyAddedModel({
    required this.id,
    required this.name,
    required this.commerialAttachment,

  });

  factory HomeRecentlyAddedModel.fromJson(Map<String, dynamic> json) {
    return HomeRecentlyAddedModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? "",
        commerialAttachment: json['commerial_attachment'] ?? "",

    );
  }
}
