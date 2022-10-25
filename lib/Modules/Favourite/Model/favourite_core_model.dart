import '../../Service Provider/Sp_Products/Model/sp_products_model.dart';

class FavouriteCoreModel {

  List<SpProductModel>? products;


  FavouriteCoreModel({
    required this.products,

  });

  factory FavouriteCoreModel.fromJson(Map<String, dynamic>? json) {
    return FavouriteCoreModel(

      products: json!['Product'] != null
          ? List<SpProductModel>.from(
          json['Product'].map((products) => SpProductModel.fromJson(products)))
          : [],

    );
  }
}