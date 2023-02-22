class StoreListSubscriptionCoreModel {


  List<ListSubscription>? subscriptions;

  StoreListSubscriptionCoreModel({ this.subscriptions});

  StoreListSubscriptionCoreModel.fromJson(Map<String, dynamic>? json) {

    if (json!['subscription'] != null) {
      subscriptions = <ListSubscription>[];
      json['subscription'].forEach((v) {
        subscriptions!.add(new ListSubscription.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subscriptions != null) {
      data['subscription'] = this.subscriptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class ListSubscription {
  int? id;
  String? name;
  int? duration;
  int? price;

  ListSubscription(
      {this.id, this.name, this.duration, this.price});

  ListSubscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    duration = json['duration'];
    price = json['price'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['duration'] = this.duration;
    data['price'] = this.price ;

    return data;
  }
}