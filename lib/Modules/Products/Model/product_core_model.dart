
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Model/sp_products_model.dart';

class ProductCoreModel {

  List<SpProductModel>? products;


  ProductCoreModel({
    required this.products,

  });

  factory ProductCoreModel.fromJson(Map<String, dynamic>? json) {
    return ProductCoreModel(

      products: json!['product'] != null
          ? List<SpProductModel>.from(
          json['product'].map((products) => SpProductModel.fromJson(products)))
          : [],

    );
  }
}