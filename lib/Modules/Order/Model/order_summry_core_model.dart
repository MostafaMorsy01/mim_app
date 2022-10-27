import 'order_item_model.dart';

class OrderSummryCoreModel {
  List<OrderItem>? orderItem;
  String? address;
  String? paymentType;

  OrderSummryCoreModel({this.orderItem, this.address, this.paymentType});

  OrderSummryCoreModel.fromJson(Map<String, dynamic> json) {
    if (json['order_item'] != null) {
      orderItem = <OrderItem>[];
      json['order_item'].forEach((v) {
        orderItem!.add(new OrderItem.fromJson(v));
      });
    }
    address = json['address'];
    paymentType = json['payment_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderItem != null) {
      data['order_item'] = this.orderItem!.map((v) => v.toJson()).toList();
    }
    data['address'] = this.address;
    data['payment_type'] = this.paymentType;
    return data;
  }
}