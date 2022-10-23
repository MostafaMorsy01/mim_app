import 'package:flutter/material.dart';
import 'package:meem_app/Models/api_response_model.dart';
import 'package:meem_app/Models/category_model.dart';
import 'package:meem_app/Models/city_model.dart';
import 'package:meem_app/Models/shipping_company_model.dart';
import 'package:meem_app/Models/sp_signup_list_data_model.dart';
import 'package:meem_app/Modules/Authentication/authentication_navigations.dart';
import 'package:meem_app/Services/check_api_status_service.dart';
import 'package:meem_app/Services/common_functions.dart';
import 'package:meem_app/Services/secure_storage_services.dart';
import '/../../Constants/app_enums.dart';
import '/../../Models/user_model.dart';
import 'authentication_web_services.dart';
import 'package:file_picker/file_picker.dart';

class AuthenticationViewModel with ChangeNotifier {
  User? user;
  String? accessToken;
  AuthenticationWebServices webServices = AuthenticationWebServices();
  Status status = Status.success;
  Status secondaryStatus = Status.success;
  SpSignupListData? spSignupListData;
  List<String> commercialRegisterList = [];
  List<String> commercialRegisterListExtensions = [];
  String nationalIdAttachemnt = "";
  String? nationalIdAttachemntExtension;
  String accountVerificationAttachemnt = "";
  String? accountVerificationAttachemntExtension;
  bool isUserSelected = true;
  int userId = 0;
  bool authenticated = false;

  Future<bool> userSignUp(
    String name,
    String email,
    String phone,
    String password,
    BuildContext context,
  ) async {
    status = Status.loading;
    notifyListeners();
    try {
      Map<String, dynamic> body = {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
      };
      APIResponse response = await webServices.userSignUp(body);
      bool statusCodeCheck = checkStatusCode(context, response);
      if (statusCodeCheck) {
        userId = response.item!;
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

  // Future<bool> fetchListCodes(
  //   BuildContext context,
  // ) async {
  //   status = Status.loading;
  //   notifyListeners();
  //   try {
  //     APIResponse response = await webServices.fetchListCodes();
  //     bool statusCodeCheck = checkStatusCode(context, response);
  //     if (statusCodeCheck) {
  //       status = Status.success;
  //       notifyListeners();
  //       return true;
  //     } else {
  //       status = Status.failed;
  //       notifyListeners();
  //       return false;
  //     }
  //   } catch (error) {
  //     status = Status.failed;
  //     notifyListeners();
  //     return false;
  //   }
  // }

  Future<bool> login(
    String email,
    String password,
    String deviceType,
    String userType,
    BuildContext context,
  ) async {
    status = Status.loading;
    notifyListeners();
    try {
      Map<String, dynamic> body = {
        "username": email,
        "password": password,
        "deviceType": deviceType,
        "userType": userType,
      };
      APIResponse response = await webServices.login(body);
      //TODO: Change (Fix the status code problem)
      if (response.status == 105) {
        AuthenticationNavigations.phoneVerificationNavigation(
            context, isUserSelected ? "user" : "store");
        //TODO: Resend code
        return true;
      } else {
        bool statusCodeCheck = checkStatusCode(context, response);
        if (statusCodeCheck) {
          user = User.fromJson(response.data!['user']);
          accessToken = response.message;
          print(accessToken);
          SecureStorageService.storeByKey("user", response.data!['user']);
          SecureStorageService.storeByKey("accessToken",accessToken);
          authenticated = true;
          status = Status.success;
          notifyListeners();
          return true;
        } else {
          status = Status.failed;
          notifyListeners();
          return false;
        }
      }
    } catch (error) {
      status = Status.failed;
      notifyListeners();
      return false;
    }
  }

  Future<bool> verifyCode(
    String userId,
    String deviceType,
    String code,
    String userType,
    BuildContext context,
  ) async {
    status = Status.loading;
    notifyListeners();
    try {
      Map<String, dynamic> body = {
        "user_id": userId,
        "deviceType": deviceType,
        "code": code,
        "userType": userType,
      };
      APIResponse response = await webServices.verifyCode(body);
      bool statusCodeCheck = checkStatusCode(context, response);
      if (statusCodeCheck) {
        user = User.fromJson(response.data!['user']);
        accessToken = response.message;
        SecureStorageService.storeByKey("user", response.data!['user']);
        SecureStorageService.storeByKey("accessToken", response.message);
        authenticated = true;
        print(response.message);
        status = Status.success;
        notifyListeners();
        Navigator.of(context).popUntil((route) => route.isFirst);
        // Navigator.popUntil(context, ModalRoute.withName("/"));

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

  Future<bool> forgotPassword(
    String phone,
    BuildContext context,
  ) async {
    status = Status.loading;
    notifyListeners();
    try {
      Map<String, dynamic> body = {
        "phone": userId,
        "userType": isUserSelected ? "user" : "store",
      };
      APIResponse response = await webServices.forgotPassword(body);
      bool statusCodeCheck = checkStatusCode(context, response);
      if (statusCodeCheck) {
        userId = response.item!;
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

  Future<bool> resetPassword(
    String code,
    String deviceType,
    String password,
    String passwordConfirmation,
    String userType,
    BuildContext context,
  ) async {
    status = Status.loading;
    notifyListeners();
    try {
      Map<String, dynamic> body = {
        "code": code,
        "user_id": userId,
        "deviceType": deviceType,
        "pasword": password,
        "passwordConfirmation": passwordConfirmation,
        "userType": userType,
        "firebase_token": ""
      };
      APIResponse response = await webServices.resetPassword(body);
      bool statusCodeCheck = checkStatusCode(context, response);
      if (statusCodeCheck) {
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

  Future<bool> logout(
    BuildContext context,
  ) async {
    status = Status.loading;
    notifyListeners();
    try {
      Map<String, dynamic> body = {
        "userType": isUserSelected ? "user" : "store",
      };
      // APIResponse response = await webServices.logout(body);
      // bool statusCodeCheck = checkStatusCode(context, response);
      // if (statusCodeCheck) {

      CommonFunctions.cleanBeforeLogout(context);
      authenticated = false;
      status = Status.success;
      notifyListeners();
      // Navigator.of(context).popUntil((route) => route.isFirst);
      return true;
      // } else {
      //   status = Status.failed;
      //   notifyListeners();
      //   return false;
      // }
    } catch (error) {
      status = Status.failed;
      notifyListeners();
      return false;
    }
  }

  Future<void> resendCode(
    String userId,
    String userType,
    BuildContext context,
  ) async {
    secondaryStatus = Status.loading;
    notifyListeners();
    try {
      Map<String, dynamic> body = {
        "user_id": userId,
        "userType": userType,
      };
      Map<String, dynamic> response = await webServices.resendCode(body);

      if (response['status'] == 200) {
        secondaryStatus = Status.success;
        notifyListeners();
      } else {
        secondaryStatus = Status.failed;
        notifyListeners();
      }
    } catch (error) {
      secondaryStatus = Status.failed;
      notifyListeners();
    }
  }

  Future<bool> spRegisterStore(
    String name,
    String email,
    String phone,
    String password,
    List<City> cities,
    List<ShippingCompany> shippingCompanies,
    List<Category> categories,
    String account,
    BuildContext context,
  ) async {
    status = Status.loading;
    notifyListeners();
    try {
      Map<String, String> body = {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        for (int i = 0; i < cities.length; i++)
          "cities[$i]": cities[i].id.toString(),
        for (int i = 0; i < categories.length; i++)
          "categories[$i]": categories[i].id.toString(),
        for (int i = 0; i < shippingCompanies.length; i++)
          "shipping_companies[$i]": shippingCompanies[i].id.toString(),
        "account": account,
      };

      APIResponse response = await webServices.spRegisterStore(
          body,
          nationalIdAttachemnt,
          accountVerificationAttachemnt,
          commercialRegisterList);
      bool statusCodeCheck = checkStatusCode(context, response);
      if (statusCodeCheck) {
        userId = response.item!;
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

  Future<void> spGetListData(
    BuildContext context,
  ) async {
    secondaryStatus = Status.loading;
    notifyListeners();
    try {
      Map<String, dynamic> response = await webServices.spGetListData();
      if (response['status'] == 200) {
        spSignupListData = SpSignupListData.fromJson(response['data']);
        print("list data");
        print(spSignupListData);
        secondaryStatus = Status.success;
        notifyListeners();
      } else if (response['status'] == 400) {
        secondaryStatus = Status.failed;
        notifyListeners();
      } else {
        secondaryStatus = Status.failed;
        notifyListeners();
      }
    } catch (e, stack) {
      secondaryStatus = Status.failed;
      notifyListeners();
    }
  }

  Future<void> pickCommercialRegisterFiles() async {
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

  Future<void> pickNationalidFiles() async {
    nationalIdAttachemnt = "";
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'pdf', 'jpg', 'PNG'],
    );
    if (result != null) {
      nationalIdAttachemnt = result.files.single.path!;
      nationalIdAttachemntExtension = result.files.single.extension!;
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
      allowedExtensions: ['png', 'pdf', 'jpg', 'PNG'],
    );
    if (result != null) {
      accountVerificationAttachemnt = result.files.single.path!;
      accountVerificationAttachemntExtension = result.files.single.extension!;
      notifyListeners();
    } else {
      accountVerificationAttachemnt = "";
      notifyListeners();
    }
  }
}
