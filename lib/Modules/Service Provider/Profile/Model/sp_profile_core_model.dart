class SpProfileCoreModel {
  Store? store;

  SpProfileCoreModel({this.store});

  SpProfileCoreModel.fromJson(Map<String, dynamic>? json) {
    store = json!['store'] != null ? new Store.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    return data;
  }
}

class Store {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? password;
  List<Categories>? categories;
  String? iDAttachment;
  String? storeImage;
  List<CommerialAttachment>? commerialAttachment;
  List<Cities>? cities;
  List<ShippingCompanies>? shippingCompanies;

  Store(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.password,
        this.categories,
        this.iDAttachment,
        this.storeImage,
        this.commerialAttachment,
        this.cities,
        this.shippingCompanies});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    iDAttachment = json['iD_attachment'];
    storeImage = json['storeImage'];
    if (json['commerial_attachment'] != null) {
      commerialAttachment = <CommerialAttachment>[];
      json['commerial_attachment'].forEach((v) {
        commerialAttachment!.add(new CommerialAttachment.fromJson(v));
      });
    }
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
    if (json['shipping_companies'] != null) {
      shippingCompanies = <ShippingCompanies>[];
      json['shipping_companies'].forEach((v) {
        shippingCompanies!.add(new ShippingCompanies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['iD_attachment'] = this.iDAttachment;
    data['storeImage'] = this.storeImage;
    if (this.commerialAttachment != null) {
      data['commerial_attachment'] =
          this.commerialAttachment!.map((v) => v.toJson()).toList();
    }
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    if (this.shippingCompanies != null) {
      data['shipping_companies'] =
          this.shippingCompanies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? image;
  List<Stores>? stores;

  Categories({this.id, this.name, this.image, this.stores});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores!.add(new Stores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    if (this.stores != null) {
      data['stores'] = this.stores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stores {
  int? id;
  String? name;
  String? commerialAttachment;

  Stores({this.id, this.name, this.commerialAttachment});

  Stores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    commerialAttachment = json['commerial_attachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['commerial_attachment'] = this.commerialAttachment;
    return data;
  }
}

class CommerialAttachment {
  int? id;
  String? path;

  CommerialAttachment({this.id, this.path});

  CommerialAttachment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['path'] = this.path;
    return data;
  }
}

class Cities {
  int? id;
  String? name;

  Cities({this.id, this.name});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ShippingCompanies {
  int? id;
  String? name;
  String? logo;

  ShippingCompanies({this.id, this.name, this.logo});

  ShippingCompanies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
}