
import 'package:dio/dio.dart';

import '../../../../Constants/app_endpoints.dart';
import '../../../../Models/api_response_model.dart';
import '../../../../Services/secure_storage_services.dart';

class ProductsWebServices {

  String? _token;


  Future<APIResponse?> fetchProductsData(int? productId) async {
    APIResponse? apiResponse;
    Response? response;
    print("tokenn");

    await SecureStorageService.readByKey("accessToken").then((value) => {
      _token = value,
    });
    print(_token);
    try {
      response = await Dio().get(
        EndPoints.baseUrl + EndPoints.get_products +"/$productId" ,
        options: Options(
            headers: {
              'content-language':'ar',
              'Accept':'application/json',
              'Authorization': 'Bearer $_token',
            }
        ),
      );
      print("responseee");
      print(response.data);
      apiResponse = APIResponse.fromJson(response.data);
      print(response.data);
      return apiResponse;

      return response.data;

      // if (response.statusCode == 200) {
      //   return {
      //     "status": response.statusCode,
      //     "data": response.data['data'],
      //     "message": "Success",
      //   };
      // } else if (response.statusCode == 400) {
      //   return {
      //     "status": response.statusCode,
      //     "data": null,
      //     "message": response.data['message'],
      //   };
      // } else if (response.statusCode == 401) {
      //   return {
      //     "status": response.statusCode,
      //     "data": null,
      //     "message": response.data['message'],
      //   };
      // } else {
      //   return {
      //     "status": response.statusCode,
      //     "data": null,
      //     "message": response.data['message'],
      //   };
      // }
    } catch (error) {
      print(error);
      // return {
      //   "status": response?.statusCode,
      //   "data": null,
      //   "message": "Something went wrong",
      // };
    }
  }

  Future<APIResponse?> searchProductsData(Map<String, dynamic> body) async {
    APIResponse? apiResponse;
    Response? response;
    print("tokenn");

    await SecureStorageService.readByKey("accessToken").then((value) => {
      _token = value,
    });
    print(_token);
    try {
      response = await Dio().post(
        EndPoints.baseUrl + EndPoints.search ,
        data: FormData.fromMap(body),
        options: Options(
            headers: {
              'content-language':'ar',
              'Accept':'application/json',
              'Authorization': 'Bearer $_token',
            },

        ),

      );
      print("responseee");
      print(response.data);
      apiResponse = APIResponse.fromJson(response.data);
      print(response.data);
      return apiResponse;

      return response.data;

      // if (response.statusCode == 200) {
      //   return {
      //     "status": response.statusCode,
      //     "data": response.data['data'],
      //     "message": "Success",
      //   };
      // } else if (response.statusCode == 400) {
      //   return {
      //     "status": response.statusCode,
      //     "data": null,
      //     "message": response.data['message'],
      //   };
      // } else if (response.statusCode == 401) {
      //   return {
      //     "status": response.statusCode,
      //     "data": null,
      //     "message": response.data['message'],
      //   };
      // } else {
      //   return {
      //     "status": response.statusCode,
      //     "data": null,
      //     "message": response.data['message'],
      //   };
      // }
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
