import 'package:dio/dio.dart';

import '../../../Constants/app_endpoints.dart';
import '../../../Models/api_response_model.dart';
import '../../../Services/secure_storage_services.dart';

class UpdateCartWebServices {
  String? _token;

  Future<APIResponse> updateCart(Map<String, dynamic> body) async {
    await SecureStorageService.readByKey("accessToken").then((value) => {
      _token = value,
    });
    print(_token);
    APIResponse? apiResponse;
    try {
      Response response = await Dio().post(
          EndPoints.baseUrl + EndPoints.update_cart,

          data: FormData.fromMap(body), options: Options(
        headers: {
          'content-language':'ar',
          'Accept':'application/json',
          'Authorization': 'Bearer $_token',
        },
        validateStatus: (_) {
          return true;
        },
      ));
      apiResponse = APIResponse.fromJson(response.data);
      return apiResponse;
    } catch (error) {
      return APIResponse.fromJson({
        "status": 404,
        "data": null,
        "message": "something_went_wrong",
        "item": 0,
        "validation": []
      });
    }
  }


}