class ProfileCoreModel {
  User? user;

  ProfileCoreModel({this.user});

  ProfileCoreModel.fromJson(Map<String, dynamic>? json) {
    user = json!['user'] != null ? new User.fromJson(json!['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  Null? firebaseToken;

  User({this.id, this.name, this.email, this.phone, this.firebaseToken});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    firebaseToken = json['firebase_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['firebase_token'] = this.firebaseToken;
    return data;
  }
}