class ShippingCompany {
  int id;
  String name;
  String logo;
  bool selected;

  ShippingCompany({
    required this.id,
    required this.name,
    required this.logo,
    this.selected = false,
  });

  factory ShippingCompany.fromJson(Map<String, dynamic> json) {
    return ShippingCompany(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      logo: json['logo'] ?? "",
    );
  }
}
