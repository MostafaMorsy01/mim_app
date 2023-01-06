class PaymentMethodCoreModel {
  List<PaymentTypes>? paymentTypes;

  PaymentMethodCoreModel({this.paymentTypes});

  PaymentMethodCoreModel.fromJson(Map<String, dynamic>? json) {
    if (json!['payment_types'] != null) {
      paymentTypes = <PaymentTypes>[];
      json['payment_types'].forEach((v) {
        paymentTypes!.add(new PaymentTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentTypes != null) {
      data['payment_types'] =
          this.paymentTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentTypes {
  int? id;
  String? name;
  bool? selected;

  PaymentTypes({
    required this.id,
    required this.name,
    this.selected = false,
  });

  PaymentTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}