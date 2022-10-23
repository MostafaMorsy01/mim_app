class HomeCarouselModel {
  int id;
  String title;
  String image;
  String link;

  HomeCarouselModel({
    required this.id,
    required this.title,
    required this.image,
    required this.link
  });

  factory HomeCarouselModel.fromJson(Map<String, dynamic> json) {
    return HomeCarouselModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? "",
      image: json['image'] ?? "",
      link: json['link'] ?? ""
    );
  }
}
