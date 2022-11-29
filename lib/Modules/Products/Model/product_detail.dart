import 'package:meem_app/Modules/Products/Model/specfication_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Model/specification_model.dart';

class ProductDetailModel {
  int? id;
  String? name;
  int? price;
  int? quantity;
  String? description;
  String? store;
  int? isFavorite;
  int? inCart;
  List<Specification>? specification;
  List<Images>? images;

  ProductDetailModel(
      {this.id,
        this.name,
        this.price,
        this.quantity,
        this.description,
        this.store,
        this.isFavorite,
        this.inCart,
        this.specification,
        this.images});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    description = json['description'];
    store = json['store'];
    isFavorite = json['is_favorite'];
    inCart = json['in_cart'];
    if (json['specification'] != null) {
      specification = <Specification>[];
      json['specification'].forEach((v) {
        specification!.add(new Specification.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['description'] = this.description;
    data['store'] = this.store;
    data['is_favorite'] = this.isFavorite;
    data['in_cart'] = this.inCart;
    if (this.specification != null) {
      data['specification'] =
          this.specification!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class Specification {
//   String? name;
//   String? value;
//
//   Specification({this.name, this.value});
//
//   Specification.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     value = json['value'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['value'] = this.value;
//     return data;
//   }
// }

class Images {
  int? id;
  String? path;

  Images({this.id, this.path});

  Images.fromJson(Map<String, dynamic> json) {
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