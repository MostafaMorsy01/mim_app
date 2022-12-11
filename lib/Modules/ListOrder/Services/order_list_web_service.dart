
import 'package:dio/dio.dart';

import '../../../../Constants/app_endpoints.dart';
import '../../../../Models/api_response_model.dart';
import '../../../../Services/secure_storage_services.dart';

class OrderListWebServices {

  String? _token;



  Future<APIResponse?> orderList(Map<String, dynamic> body) async {
    APIResponse apiResponse;
    await SecureStorageService.readByKey("accessToken").then((value) => {
      _token = value,
    });
    print(_token);

    try {
      Response response = await Dio().post(EndPoints.baseUrl + EndPoints.order_list,
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
