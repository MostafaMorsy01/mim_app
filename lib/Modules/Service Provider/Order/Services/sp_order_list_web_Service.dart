
import 'package:dio/dio.dart';

import '../../../../Constants/app_endpoints.dart';
import '../../../../Models/api_response_model.dart';
import '../../../../Services/secure_storage_services.dart';

class SpOrderListWebServices {

  String? _token;


  Future<APIResponse> orderSummary(int? product_id) async {
    APIResponse apiResponse;
    await SecureStorageService.readByKey("accessToken").then((value) => {
      _token = value,
    });
    print(_token);
    try {
      Response response = await Dio().get(EndPoints.baseUrl + EndPoints.sp_order_list + "/${product_id}",
          options: Options(
            headers: {
              'content-language':'ar',
              'Accept':'application/json',
              'Authorization': 'Bearer $_token',
            },

          ));

      apiResponse = APIResponse.fromJson(response.data);
      print(apiResponse);
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

  Future<APIResponse?> orderList(Map<String, dynamic> body) async {
    APIResponse apiResponse;
    await SecureStorageService.readByKey("accessToken").then((value) => {
      _token = value,
    });
    print(_token);

    try {
      Response response = await Dio().post(EndPoints.baseUrl + EndPoints.sp_order_list,
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

      print("responseee");
      print(response.data);
      apiResponse = APIResponse.fromJson(response.data);

      return apiResponse;
    } catch (error) {
      print(error);
      // return {
      //   "status": response?.statusCode,
      //   "data": null,
      //   "message": "Something went wrong",
      // };
    }
  }

  Future<APIResponse?> changeOrderStatus(Map<String, dynamic> body) async {
    APIResponse apiResponse;
    await SecureStorageService.readByKey("accessToken").then((value) => {
      _token = value,
    });
    print(_token);

    try {
      Response response = await Dio().post(EndPoints.baseUrl + EndPoints.sp_order_status,
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

      print("responseee");
      print(response.data);
      apiResponse = APIResponse.fromJson(response.data);

      return apiResponse;
    } catch (error) {
      print(error);
      // return {
      //   "status": response?.statusCode,
      //   "data": null,
      //   "message": "Something went wrong",
      // };
    }
  }




}
