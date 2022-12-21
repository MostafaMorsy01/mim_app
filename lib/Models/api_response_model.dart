class APIResponse {
  int? status;
  Map<String, dynamic>? data;
  String? message;
  List<String>? validation;
  int? item;
  APIResponse({
     this.status,
    this.message,
    this.validation,
    this.item,
    this.data,
  });

  APIResponse.fromJson(Map<String, dynamic>? json) {

    status = json!['code'];
    data = json['data'] ?? {};
    message = json['message'];
    item = json['item'];
    try {
      if (json['validation'] != null ) {
        if(json['validation'].toString()!="[]" ){
          validation = List<String>.from(json['validation']);
        }
      }

    } catch (e){
      validation = null;
    }

    // return APIResponse(
    //   status: json!['code'] ?? 200,
    //   data: json['data'] ?? {},
    //   message: json['message'] ?? "",
    //   try{
    //
    //    } catch(e) {
    //
    // }
    //   // validation: ,
    //
    //   // validation: json['validation'].cast<String>(),
    //   //     // json['validation'] == null ? [] : List<String>.from(['validation']),
    //   item: json['item'] ?? 0,

  }
}
