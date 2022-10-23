import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:meem_app/Models/shipping_company_model.dart';
import 'package:meem_app/Models/sp_signup_list_data_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Authentication/sp_authentication_web_services.dart';
import 'package:file_picker/file_picker.dart';
import '../../../Constants/app_enums.dart';

class SpAuthenticationViewModel with ChangeNotifier {
  SpAuthenticationWebServices webServices = SpAuthenticationWebServices();
  Status status = Status.success;
  SpSignupListData? spSignupListData;
  List<String> commercialRegisterList = [];
  String nationalIdAttachemnt = "";
  String accountVerificationAttachemnt = "";

  Future<void> spRegisterStore(
    String name,
    String email,
    String phone,
    String password,
    List<int> cities,
    List<ShippingCompany> shippingCompanies,
    List<int> categories,
    String account,
    BuildContext context,
  ) async {
    status = Status.loading;
    notifyListeners();
    try {
      status = Status.success;
      notifyListeners();
      Map<String, String> body = {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        for (int i = 0; i < cities.length; i++)
          "cities[$i]": cities[i].toString(),
        for (int i = 0; i < categories.length; i++)
          "categories[$i]": categories[i].toString(),
        for (int i = 0; i < shippingCompanies.length; i++)
          "shipping_companies[$i]": shippingCompanies[i].id.toString(),
        "account": account,
      };

      Map<String, dynamic> response = await webServices.spRegisterStore(
          body,
          nationalIdAttachemnt,
          accountVerificationAttachemnt,
          commercialRegisterList);
      if (response['status'] == 200) {
        status = Status.success;
        notifyListeners();
      } else if (response['status'] == 400) {
        status = Status.failed;
        notifyListeners();
      } else {
        status = Status.failed;
        notifyListeners();
      }
    } catch (e, stack) {
      status = Status.failed;
      notifyListeners();
    }
  }

  Future<void> spGetListData(
    BuildContext context,
  ) async {
    status = Status.loading;
    notifyListeners();
    try {
      Map<String, dynamic> response = await webServices.spGetListData();
      if (response['status'] == 200) {
        spSignupListData = SpSignupListData.fromJson(response['data']);
        status = Status.success;
        notifyListeners();
      } else if (response['status'] == 400) {
        status = Status.failed;
        notifyListeners();
      } else {
        status = Status.failed;
        notifyListeners();
      }
    } catch (e) {
      status = Status.failed;
      notifyListeners();
    }
  }

  Future<void> pickCommercialRegisterFiles() async {
    commercialRegisterList = [];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['png', 'pdf', 'jpg'],
    );
    if (result != null) {
      commercialRegisterList = result.paths.map((path) => path!).toList();
      notifyListeners();
    } else {
      commercialRegisterList = [];
      notifyListeners();
    }
  }

  Future<void> pickNationalidFiles() async {
    nationalIdAttachemnt = "";
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'pdf', 'jpg'],
    );
    if (result != null) {
      nationalIdAttachemnt = result.files.single.path!;
      notifyListeners();
    } else {
      nationalIdAttachemnt = "";
      notifyListeners();
    }
  }

  Future<void> pickAccountverification() async {
    accountVerificationAttachemnt = "";
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'pdf', 'jpg'],
    );
    if (result != null) {
      accountVerificationAttachemnt = result.files.single.path!;
      notifyListeners();
    } else {
      accountVerificationAttachemnt = "";
      notifyListeners();
    }
  }
}
