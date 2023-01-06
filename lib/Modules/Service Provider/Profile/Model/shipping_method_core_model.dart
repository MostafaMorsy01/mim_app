class ShippingMethodCoreModel {
  List<ShippingCompany>? shippingCompany;

  ShippingMethodCoreModel({this.shippingCompany});

  ShippingMethodCoreModel.fromJson(Map<String, dynamic> json) {
    if (json['shipping_company'] != null) {
      shippingCompany = <ShippingCompany>[];
      json['shipping_company'].forEach((v) {
        shippingCompany!.add(new ShippingCompany.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shippingCompany != null) {
      data['shipping_company'] =
          this.shippingCompany!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShippingCompany {
  int? id;
  String? name;
  String? logo;
  String? createdAt;
  String? updatedAt;

  ShippingCompany(
      {this.id, this.name, this.logo, this.createdAt, this.updatedAt});

  ShippingCompany.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}