class HomeFeaturedStoresModel {
  int id;
  String name;
  String commerialAttachment;


  HomeFeaturedStoresModel({
    required this.id,
    required this.name,
    required this.commerialAttachment,

  });

  factory HomeFeaturedStoresModel.fromJson(Map<String, dynamic> json) {
    return HomeFeaturedStoresModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      commerialAttachment: json['commerial_attachment'] ?? "",

    );
  }
}
