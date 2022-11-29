class StoresModel {
  int? id;
  String? name;
  String? commerialAttachment;

  StoresModel({this.id, this.name, this.commerialAttachment});

  StoresModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    commerialAttachment = json['commerial_attachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['commerial_attachment'] = this.commerialAttachment;
    return data;
  }
}