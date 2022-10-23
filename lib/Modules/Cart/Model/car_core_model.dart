import 'package:meem_app/Modules/Cart/Model/cart_item_model.dart';

class CartCoreModel {
  List<CartItem>? cartItem;
  int? subTotal;
  int? shipmentFees;
  int? total;

  CartCoreModel({this.cartItem, this.subTotal, this.shipmentFees, this.total});

  CartCoreModel.fromJson(Map<String, dynamic>? json) {
    if (json!['cart_item'] != null) {
      cartItem = <CartItem>[];
      json!['cart_item'].forEach((v) {
        cartItem!.add(new CartItem.fromJson(v));
      });
    }
    subTotal = json['sub_total'];
    shipmentFees = json['shipment_fees'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartItem != null) {
      data['cart_item'] = this.cartItem!.map((v) => v.toJson()).toList();
    }
    data['sub_total'] = this.subTotal;
    data['shipment_fees'] = this.shipmentFees;
    data['total'] = this.total;
    return data;
  }
}