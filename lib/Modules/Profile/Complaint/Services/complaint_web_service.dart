import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';

import '../../../../Constants/app_endpoints.dart';
import '../../../../Models/api_response_model.dart';
import '../../../../Services/secure_storage_services.dart';

class ComplaintWebServices {
  String? _token;

  Future<APIResponse> addComplaint(
      Map<String, String> body, List<String> imageList) async {
    await SecureStorageService.readByKey("accessToken").then((value) => {
      _token = value,
    });
    print(_token);
    print(imageList);
    http.Response? response;
    APIResponse apiResponse;
    try {
      Map<String, String> headers = {
        'content-language': 'ar',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token',
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse(EndPoints.baseUrl + EndPoints.makeComplaint));
      request.headers.addAll(headers);
      // List<MultipartFile> newList = List<MultipartFile>();

      // if(imageFile != null){
      //   request.files
      //       .add(await http.MultipartFile.fromPath('image', imageFile.path));
      // }
      // if (imageList.isNotEmpty) {
      //
      //   for (int i = 0; i < imageList.length; i++) {
      //
      //     if(imageList[i] != null){
      //       print("exist");
      //       request.files.add(await http.MultipartFile.fromPath(
      //           'images[$i]', imageList[i].path));
      //     } else {
      //       print("not exist");
      //     }
      //
      //   }
      // }
//       if (imageList.length > 0) {
//         for (var i = 0; i < imageList.length; i++) {
//
//           ByteData byteData = await imageList[i].getByteData();
//           List<int> imageData = byteData.buffer.asUint8List();
//
//           MultipartFile multipartFile = MultipartFile.fromBytes(
//             'photo',  //key of the api
//             imageData,
//             filename: 'some-file-name.jpg',
//             contentType: MediaType("image", "jpg"), //this is not nessessory variable. if this getting error, erase the line.
//           );
//
// // add file to multipart
//           request.files.add(multipartFile);
//           // request.files.add(http.MultipartFile('images[$i]',
//           //     File(imageList[i].path).readAsBytes().asStream(),
//           //     File(imageList[i].path).lengthSync(),
//           //     filename: imageList[i].path
//           //         .split("/")
//           //         .last));
//         }
//       }
      if (imageList.isNotEmpty) {
        for (int i = 0; i < imageList.length; i++) {
          request.files.add(http.MultipartFile.fromBytes(
              'attachments[$i]', File(imageList[i]).readAsBytesSync(),
              filename: imageList[i].split('/').last));
        }
      }

      print("bodyy");
      print(body);
      request.fields.addAll(body);
      response = await http.Response.fromStream(await request.send());
      apiResponse = APIResponse.fromJson(json.decode(response.body));
      print("Result: ${response.body}");
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
