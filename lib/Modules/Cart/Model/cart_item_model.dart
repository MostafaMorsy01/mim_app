import 'package:meem_app/Modules/Cart/Model/product_model.dart';

class CartItem {
  int? id;
  int? quantity;
  int? amount;
  Product? product;

  CartItem({this.id, this.quantity, this.amount, this.product});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    amount = json['amount'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['amount'] = this.amount;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}