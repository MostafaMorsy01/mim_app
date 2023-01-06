
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Model/sp_products_model.dart';

import '../../../Models/HomeModel/store_model.dart';

class StoresCoreModel {

  List<StoresModel>? stores;


  StoresCoreModel({
    required this.stores,

  });

  factory StoresCoreModel.fromJson(Map<String, dynamic>? json) {
    return StoresCoreModel(

      stores: json!['store'] != null
          ? List<StoresModel>.from(
          json['store'].map((products) => StoresModel.fromJson(products)))
          : [],

    );
  }
}