import 'package:meem_app/Modules/Products/Model/product_detail.dart';

class ProductDetailCoreModel {
  ProductDetailModel? product;

  ProductDetailCoreModel({this.product});

  ProductDetailCoreModel.fromJson(Map<String, dynamic>? json) {
    product =
    json!['product'] != null ? new ProductDetailModel.fromJson(json!['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

