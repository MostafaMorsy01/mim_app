class Specifications {
  int? id;
  String? name;
  List<Values>? values;
  String? createdAt;
  String? updatedAt;


  Specifications(
      {this.id, this.name, this.values, this.createdAt, this.updatedAt});

  Specifications.fromJson(Map<String, dynamic>? json) {
    id = json!['id'];
    name = json!['name'];
    if (json['values'] != null) {
      values = <Values>[];
      json['values'].forEach((v) {
        values!.add(new Values.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.values != null) {
      data['values'] = this.values!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Values {
  int? id;
  String? name;
  String? value;
  bool isSelected = false;

  Values({this.id, this.name, this.value});

  Values.fromJson(Map<String, dynamic>? json) {
    id = json!['id'];
    name = json!['name'];
    value = json!['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}