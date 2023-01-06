import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:meem_app/Constants/app_endpoints.dart';
import 'package:meem_app/Models/api_response_model.dart';

class AuthenticationWebServices {
  Future<APIResponse> userSignUp(Map<String, dynamic> body) async {
    APIResponse? apiResponse;
    try {
      Response response = await Dio().post(
          EndPoints.baseUrl + EndPoints.register,
          data: FormData.fromMap(body), options: Options(
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

  Future<APIResponse> verifyCode(Map<String, dynamic> body) async {
    APIResponse apiResponse;
    try {
      Response response = await Dio().post(
          EndPoints.baseUrl +
              EndPoints.verify +
              EndPoints.registration +
              EndPoints.code,
          data: FormData.fromMap(body), options: Options(
        validateStatus: (_) {
          return true;
        },
      ));
      print(response);
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

  Future<Map<String, dynamic>> resendCode(Map<String, dynamic> body) async {
    Response? response;
    try {
      response = await Dio().post(
          EndPoints.baseUrl + EndPoints.resend + EndPoints.code,
          data: FormData.fromMap(body), options: Options(
        validateStatus: (_) {
          return true;
        },
      ));
      if (response.statusCode == 200) {
        return {
          "status": response.statusCode,
          "data": response.data,
          "message": "creation_success",
        };
      } else {
        return {
          "status": response.statusCode,
          "data": null,
          "message": response.data['message'],
        };
      }
    } catch (error) {
      return {
        "status": response?.statusCode,
        "data": null,
        "message": response?.data['message'],
      };
    }
  }

  Future<APIResponse> login(Map<String, dynamic> body) async {
    APIResponse apiResponse;
    try {
      Response response = await Dio().post(EndPoints.baseUrl + EndPoints.login,
          data: FormData.fromMap(body), options: Options(
        validateStatus: (_) {
          return true;
        },
      ));

      apiResponse = APIResponse.fromJson(response.data);
      print(response.data);
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

  Future<APIResponse> spRegisterStore(
      Map<String, String> body,
      String idAttachment,
      String storePhotoAttachment,
      String accountAttachment,
      List<String> attachments) async {
    http.Response? response;
    APIResponse apiResponse;
    try {
      var request = http.MultipartRequest('POST',
          Uri.parse(EndPoints.baseUrl + EndPoints.store + EndPoints.register));
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
      if (accountAttachment != "") {
        request.files.add(http.MultipartFile.fromBytes(
            'account_attachment', File(accountAttachment).readAsBytesSync(),
            filename: accountAttachment.split('/').last));
      }
      print("object");
      if (attachments.isNotEmpty) {
        for (int i = 0; i < attachments.length; i++) {
          request.files.add(http.MultipartFile.fromBytes(
              'attachments[$i]', File(attachments[i]).readAsBytesSync(),
              filename: attachments[i].split('/').last));
        }
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

  Future<APIResponse> logout(Map<String, dynamic> body) async {
    APIResponse? apiResponse;
    try {
      Response response = await Dio().post(EndPoints.baseUrl + EndPoints.logout,
          data: FormData.fromMap(body), options: Options(
        validateStatus: (_) {
          return true;
        },
      ));
      apiResponse = APIResponse.fromJson(response.data);
      print(response.data);
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

  Future<Map<String, dynamic>> spGetListData() async {
    Response? response;

    try {
      response = await Dio().get(
        EndPoints.baseUrl + EndPoints.list + EndPoints.data,
        options: Options(
          validateStatus: (_) {
            return true;
          },
        ),
      );
      print(response.data);
      if (response.statusCode == 200) {

        return {
          "status": response.statusCode,
          "data": response.data['data'],
          "message": "Success",
        };
      } else if (response.statusCode == 400) {
        return {
          "status": response.statusCode,
          "data": null,
          "message": response.data['message'],
        };
      } else if (response.statusCode == 401) {
        return {
          "status": response.statusCode,
          "data": null,
          "message": response.data['message'],
        };
      } else {
        return {
          "status": response.statusCode,
          "data": null,
          "message": response.data['message'],
        };
      }
    } catch (error) {
      return {
        "status": response?.statusCode,
        "data": null,
        "message": "Something went wrong",
      };
    }
  }

  Future<APIResponse> forgotPassword(Map<String, dynamic> body) async {
    APIResponse apiResponse;
    try {
      Response response = await Dio().post(
          EndPoints.baseUrl + EndPoints.forgot + EndPoints.password,
          data: FormData.fromMap(body), options: Options(
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

  Future<APIResponse> resetPassword(Map<String, dynamic> body) async {
    APIResponse apiResponse;
    try {
      Response response = await Dio().post(
          EndPoints.baseUrl +
              EndPoints.reset +
              EndPoints.forgot +
              EndPoints.password,
          data: FormData.fromMap(body), options: Options(
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
