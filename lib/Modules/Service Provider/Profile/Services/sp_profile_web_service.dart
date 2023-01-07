
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import '../../../../Constants/app_endpoints.dart';
import '../../../../Models/api_response_model.dart';
import '../../../../Services/secure_storage_services.dart';
import 'package:http/http.dart' as http;

class SpProfileViewWebServices {

  String? _token;


  Future<APIResponse?> fetchSpProfileData() async {
    APIResponse? apiResponse;
    Response? response;
    print("tokenn");

    await SecureStorageService.readByKey("accessToken").then((value) => {
      _token = value,
    });
    print(_token);
    try {
      response = await Dio().get(
        EndPoints.baseUrl + EndPoints.sp_profile ,
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
  Future<APIResponse> spRegisterStore(
      Map<String, String> body,
      String idAttachment,
      String storePhotoAttachment) async {
    http.Response? response;
    APIResponse apiResponse;
    try {
      var request = http.MultipartRequest('POST',
          Uri.parse(EndPoints.baseUrl + EndPoints.sp_profile));
      if (idAttachment != "") {
        request.files.add(http.MultipartFile.fromBytes(
            'id_attachment', File(idAttachment).readAsBytesSync(),
            filename: idAttachment.split('/').last));
      }
      if (storePhotoAttachment != "") {
        request.files.add(http.MultipartFile.fromBytes(
            'image', File(storePhotoAttachment).readAsBytesSync(),
            filename: storePhotoAttachment.split('/').last));
      }



      request.fields.addAll(body);
      response = await http.Response.fromStream(await request.send());
      apiResponse = APIResponse.fromJson(json.decode(response.body));
      print(response.body);
      return apiResponse;
    } catch (error) {
      print(error);
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
