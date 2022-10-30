import 'package:meem_app/Modules/Order/Model/payment_model.dart';

class PaymentCoreModel {
  List<PaymentTypes>? paymentTypes;

  PaymentCoreModel({this.paymentTypes});

  PaymentCoreModel.fromJson(Map<String, dynamic> json) {
    if (json['payment_types'] != null) {
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