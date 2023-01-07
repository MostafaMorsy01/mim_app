class SpOrderListCoreModel {
  List<Order>? order;

  SpOrderListCoreModel({this.order});

  SpOrderListCoreModel.fromJson(Map<String, dynamic>? json) {
    if (json!['order'] != null) {
      order = <Order>[];
      json['order'].forEach((v) {
        order!.add(new Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  int? orderNumber;
  String? status;
  int? isCancelled;
  String? storeName;
  String? createdAt;

  Order(
      {this.orderNumber,
        this.status,
        this.isCancelled,
        this.storeName,
        this.createdAt});

  Order.fromJson(Map<String, dynamic> json) {
    orderNumber = json['order_number'];
    status = json['status'];
    isCancelled = json['is_cancelled'];
    storeName = json['store_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_number'] = this.orderNumber;
    data['status'] = this.status;
    data['is_cancelled'] = this.isCancelled;
    data['store_name'] = this.storeName;
    data['created_at'] = this.createdAt;
    return data;
  }
}