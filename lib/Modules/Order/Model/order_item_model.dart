class OrderItem {
  int? id;
  int? quantity;
  int? amount;
  Product? product;

  OrderItem({this.id, this.quantity, this.amount, this.product});

  OrderItem.fromJson(Map<String, dynamic> json) {
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

class Product {
  int? id;
  String? name;
  int? price;
  String? description;
  String? store;
  int? inCart;
  String? image;

  Product(
      {this.id,
        this.name,
        this.price,
        this.description,
        this.store,
        this.inCart,
        this.image});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    store = json['store'];
    inCart = json['in_cart'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['store'] = this.store;
    data['in_cart'] = this.inCart;
    data['image'] = this.image;
    return data;
  }
}