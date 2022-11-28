import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meem_app/Models/shipping_company_model.dart';
import 'package:meem_app/Models/sp_signup_list_data_model.dart';
import 'package:meem_app/Modules/Profile/Complaint/Services/complaint_web_service.dart';
import 'package:meem_app/Modules/Service%20Provider/Authentication/sp_authentication_web_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Services/sp_add_product_web_service.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import '../../../../Constants/app_enums.dart';
import '../../../../Models/api_response_model.dart';
import '../../../../Services/check_api_status_service.dart';


class ComplaintViewModel with ChangeNotifier {
  ComplaintWebServices webServices = ComplaintWebServices();
  Status status = Status.success;
  SpSignupListData? spSignupListData;
  List<String> commercialRegisterList = [];
  List<String> commercialRegisterListExtensions = [];
  List<Asset> imagesList = [];
  String nationalIdAttachemnt = "";
  String accountVerificationAttachemnt = "";

  Future<bool> spAddProductStore(
      String name,
      String email,
      String content,

      BuildContext context,
      ) async {
    print("loading");
    status = Status.loading;
    notifyListeners();
    try {
      status = Status.success;
      print("success");
      notifyListeners();
      Map<String, String> body = {
        "name": name,
        "email": email,
        "content": content,



      };
      print("go to service");
      print(imagesList);
      APIResponse response = await webServices.addComplaint(
          body,
          commercialRegisterList
      );
      bool statusCodeCheck = checkStatusCode(context, response);

      if (statusCodeCheck) {
        // userId = response.item!;
        status = Status.success;
        notifyListeners();
        return true;
      } else {
        status = Status.failed;
        notifyListeners();
        return false;
      }
    } catch (error) {
      status = Status.failed;
      notifyListeners();
      return false;
    }
  }



  Future<void> pickProductAttachmentFiles() async {
    commercialRegisterList = [];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['png', 'pdf', 'jpg', 'PNG'],
    );
    if (result != null) {
      commercialRegisterList = result.paths.map((path) => path!).toList();
      commercialRegisterListExtensions =
          result.files.map((file) => file.extension!).toList();
      notifyListeners();
    } else {
      commercialRegisterList = [];
      notifyListeners();
    }
  }
}
