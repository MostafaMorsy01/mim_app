class StoreSubscriptionCoreModel {
  String? message;
  CurrentSubscription? currentSubscription;
  List<History>? history;

  StoreSubscriptionCoreModel({this.message, this.currentSubscription, this.history});

  StoreSubscriptionCoreModel.fromJson(Map<String, dynamic>? json) {
    message = json!['message'];
    currentSubscription = json['current_subscription'] != null
        ? new CurrentSubscription.fromJson(json['current_subscription'])
        : null;
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(new History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.currentSubscription != null) {
      data['current_subscription'] = this.currentSubscription!.toJson();
    }
    if (this.history != null) {
      data['history'] = this.history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CurrentSubscription {
  int? id;
  String? name;
  String? startDate;
  String? endDate;
  int? isCancelled;

  CurrentSubscription(
      {this.id, this.name, this.startDate, this.endDate, this.isCancelled});

  CurrentSubscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    isCancelled = json['is_cancelled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['is_cancelled'] = this.isCancelled;
    return data;
  }
}
class History {
  int? id;
  String? name;
  String? startDate;
  String? endDate;
  int? isCancelled;

  History(
      {this.id, this.name, this.startDate, this.endDate, this.isCancelled});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    isCancelled = json['is_cancelled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['is_cancelled'] = this.isCancelled;
    return data;
  }
}