import 'address_model.dart';

class AddressCoreModel {
  List<Address>? address;

  AddressCoreModel({this.address});

  AddressCoreModel.fromJson(Map<String, dynamic>? json) {
    if (json!['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(new Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}