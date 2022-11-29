class Specification {
  int? id;
  String? name;
  ValuesModel? values;


  Specification({this.id, this.name, this.values});

  Specification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    values =
    json['values'] != null ? new ValuesModel.fromJson(json['values']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.values != null) {
      data['values'] = this.values!.toJson();
    }
    return data;
  }
}

class ValuesModel {
  int? id;
  String? value;
  bool isSelected = false;

  ValuesModel({this.id, this.value});

  ValuesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    return data;
  }
}