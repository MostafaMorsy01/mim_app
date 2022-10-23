class HomeCelebrityStoresModel {
  int id;
  String name;
  String commerialAttachment;


  HomeCelebrityStoresModel({
    required this.id,
    required this.name,
    required this.commerialAttachment,

  });

  factory HomeCelebrityStoresModel.fromJson(Map<String, dynamic> json) {
    return HomeCelebrityStoresModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      commerialAttachment: json['commerial_attachment'] ?? "",

    );
  }
}
