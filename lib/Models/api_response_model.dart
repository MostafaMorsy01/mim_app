class APIResponse {
  int status;
  Map<String, dynamic>? data;
  String? message;
  List<String>? validation;
  int? item;
  APIResponse({
    required this.status,
    this.message,
    this.validation,
    this.item,
    this.data,
  });

  factory APIResponse.fromJson(Map<String, dynamic>? json) {
    return APIResponse(
      status: json!['code'] ?? 200,
      data: json!['data'] ?? {},
      message: json!['message'] ?? "",
      validation:
          json!['validation'] == null ? [] : List<String>.from(['validation']),
      item: json!['item'] ?? 0,
    );
  }
}
