class Specification {
  int? id;
  String? name;
  List<ValuesModel>? values;

  Specification({this.id, this.name, this.values});

  Specification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['values'] != null) {
      values = <ValuesModel>[];
      json['values'].forEach((v) {
        values!.add(new ValuesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.values != null) {
      data['values'] = this.values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ValuesModel {
  int? id;
  String? name;
  String? value;
  bool isSelected = false;

  ValuesModel({this.id, this.value, this.name});

  ValuesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['name'] = this.name;
    return data;
  }
}