class SpProductModel {
  int? id;
  String? name;
  int? price;
  String? description;
  String? store;
  int? inCart;
  String? image;

  SpProductModel(
      {this.id,
        this.name,
        this.price,
        this.description,
        this.store,
        this.inCart,
        this.image});

  SpProductModel.fromJson(Map<String, dynamic> json) {
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