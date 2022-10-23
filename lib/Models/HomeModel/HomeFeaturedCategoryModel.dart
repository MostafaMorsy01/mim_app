class HomeFeaturedCategoryModel {
  int id;
  String name;
  String image;
  List<dynamic> stores;

  HomeFeaturedCategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.stores
  });

  factory HomeFeaturedCategoryModel.fromJson(Map<String, dynamic> json) {
    return HomeFeaturedCategoryModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? "",
        image: json['image'] ?? "",
        stores: json['stores'] ?? []
    );
  }
}
