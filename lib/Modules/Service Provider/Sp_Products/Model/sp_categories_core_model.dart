import 'categories_model.dart';

class CategoriesCoreModel {
  List<Categories>? categories;

  CategoriesCoreModel({this.categories});

  CategoriesCoreModel.fromJson(Map<String, dynamic>? json) {
    if (json!['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}