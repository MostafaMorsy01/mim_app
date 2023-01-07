import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meem_app/Models/shipping_company_model.dart';
import 'package:meem_app/Models/sp_signup_list_data_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Authentication/sp_authentication_web_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Services/sp_add_product_web_service.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import '../../../../Constants/app_enums.dart';
import '../../../../Models/api_response_model.dart';
import '../../../../Services/check_api_status_service.dart';


class SpAddProductViewModel with ChangeNotifier {
  SpAddProductWebServices webServices = SpAddProductWebServices();
  Status status = Status.success;
  SpSignupListData? spSignupListData;
  List<String> commercialRegisterList = [];
  List<String> commercialRegisterListExtensions = [];
  List<Asset> imagesList = [];
  String nationalIdAttachemnt = "";
  String accountVerificationAttachemnt = "";

  Future<bool> spAddProductStore(
      String name_en,
      String name_ar,
      String description,
      int price,
      int qty,
      int catId,
      List<int> specifications,
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
        "name_en": name_en,
        "name_ar": name_ar,
        "description": description,
        "price": price.toString(),
        "quantity": qty.toString(),

        "category_id": catId.toString(),
        for (int i = 0; i < specifications.length; i++)
          "specification_values[$i]": specifications[i].toString(),
        // for (int i = 0; i < imagesList.length; i++)
        //   "imagesList[$i]": imagesList[i].toString(),

      };
      print("go to service");
      print(imagesList);
      APIResponse response = await webServices.spAddProductStore(
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
