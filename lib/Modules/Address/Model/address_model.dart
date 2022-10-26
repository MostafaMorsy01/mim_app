class Address {
  int? id;
  String? name;
  String? street;
  String? area;
  String? city;
  String? specificSign;
  int? isPrimary;

  Address({this.id,
    this.name,
    this.street,
    this.area,
    this.city,
    this.specificSign,
    this.isPrimary});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    street = json['street'];
    area = json['area'];
    city = json['city'];
    specificSign = json['specific_sign'];
    isPrimary = json['is_primary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['street'] = this.street;
    data['area'] = this.area;
    data['city'] = this.city;
    data['specific_sign'] = this.specificSign;
    data['is_primary'] = this.isPrimary;
    return data;
  }
}