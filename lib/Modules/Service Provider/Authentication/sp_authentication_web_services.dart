import 'dart:io';

import 'package:dio/dio.dart';
import '../../../Constants/app_endpoints.dart';
import 'package:http/http.dart' as http;

class SpAuthenticationWebServices {
  Future<Map<String, dynamic>> spRegisterStore(
      Map<String, String> body,
      String idAttachment,
      String accountAttachment,
      List<String> attachments) async {
    print("object");
    http.Response? response;
    print("object");
    try {
      var request = http.MultipartRequest('POST',
          Uri.parse(EndPoints.baseUrl + EndPoints.store + EndPoints.register));
      if (idAttachment != "") {
        request.files.add(http.MultipartFile.fromBytes(
            'id_attachment', File(idAttachment).readAsBytesSync(),
            filename: idAttachment.split('/').last));
      }
      if (accountAttachment != "") {
        request.files.add(http.MultipartFile.fromBytes(
            'account_attachment', File(accountAttachment).readAsBytesSync(),
            filename: accountAttachment.split('/').last));
      }
      if (attachments.isNotEmpty) {
        for (int i = 0; i < attachments.length; i++) {
          request.files.add(http.MultipartFile.fromBytes(
              'attachments[$i]', File(attachments[i]).readAsBytesSync(),
              filename: attachments[i].split('/').last));
        }
      }
      request.fields.addAll(body);
      response = await http.Response.fromStream(await request.send());

      print("Result: ${response.body}");
      if (response.statusCode == 200) {
        return {
          "status": response.statusCode,
          "data": response.body,
          "message": "Created successfully",
        };
      } else if (response.statusCode == 400) {
        return {
          "status": response.statusCode,
          "data": null,
          // "message": response.body['message'],
        };
      } else {
        return {
          "status": response.statusCode,
          "data": null,
          // "message": response.data['message'],
        };
      }
    } catch (error) {
      print(error);
      return {
        "status": response?.statusCode,
        "data": null,
        // "message": response?.data['message'],
      };
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
}
