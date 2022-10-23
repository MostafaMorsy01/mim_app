
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Model/sp_products_model.dart';

class SpProductCoreModel {

  List<SpProductModel>? spProducts;


  SpProductCoreModel({
    required this.spProducts,

  });

  factory SpProductCoreModel.fromJson(Map<String, dynamic>? json) {
    return SpProductCoreModel(

      spProducts: json!['product'] != null
          ? List<SpProductModel>.from(
          json['product'].map((spProducts) => SpProductModel.fromJson(spProducts)))
          : [],

    );
  }
}