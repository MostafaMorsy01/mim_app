import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Model/specification_model.dart';

class SpecificationCoreModel {
  List<Specifications>? specifications;

  SpecificationCoreModel({this.specifications});

  SpecificationCoreModel.fromJson(Map<String, dynamic>? json) {
    if (json!['specifications'] != null) {
      specifications = <Specifications>[];
      json!['specifications'].forEach((v) {
        specifications!.add(new Specifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.specifications != null) {
      data['specifications'] =
          this.specifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}