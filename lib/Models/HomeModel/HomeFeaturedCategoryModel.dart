import 'package:meem_app/Models/HomeModel/store_model.dart';

import '../../Modules/Service Provider/Sp_Products/Model/categories_model.dart';

class HomeFeaturedCategoryModel {
  int? id;
  String? name;
  String? image;
  List<StoresModel>? stores;

  HomeFeaturedCategoryModel({this.id, this.name, this.image, this.stores});

  HomeFeaturedCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['stores'] != null) {
      stores = <StoresModel>[];
      json['stores'].forEach((v) {
        stores!.add(new StoresModel.fromJson(v));
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
