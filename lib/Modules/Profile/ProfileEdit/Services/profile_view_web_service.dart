
import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../Constants/app_endpoints.dart';
import '../../../../Models/api_response_model.dart';
import '../../../../Services/secure_storage_services.dart';
import 'package:http/http.dart' as http;

class ProfileViewWebServices {

  String? _token;


  Future<APIResponse?> fetchProfileData() async {
    APIResponse? apiResponse;
    Response? response;
    print("tokenn");

    await SecureStorageService.readByKey("accessToken").then((value) => {
      _token = value,
    });
    print(_token);
    try {
      response = await Dio().get(
        EndPoints.baseUrl + EndPoints.profile ,
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
  Future<APIResponse> editProfileInfo(
      Map<String, String> body, ) async {
    await SecureStorageService.readByKey("accessToken").then((value) => {
      _token = value,
    });
    print(_token);
    http.Response? response;
    APIResponse apiResponse;
    try {
      Map<String, String> headers = {
        'content-language': 'ar',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token',
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse(EndPoints.baseUrl + EndPoints.profile));
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
