
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Favourite/Service/list_favourite_web_service.dart';
import 'package:meem_app/Modules/Profile/ProfileEdit/Model/profile_core_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Model/Sp_Product_core_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Services/sp_products_web_services.dart';

import '../../../../Constants/app_enums.dart';
import '../../../../Models/api_response_model.dart';
import '../../../../Models/category_model.dart';
import '../../../../Models/city_model.dart';
import '../../../../Models/user_model.dart';
import '../../../../Services/check_api_status_service.dart';
import '../../../Favourite/Model/favourite_core_model.dart';
import '../Model/sp_profile_core_model.dart';
import '../Services/sp_profile_web_service.dart';



class SpProfileViewModel with ChangeNotifier {
  // User? user;
  String? accessToken;
  Status status = Status.success;
  Status secondaryStatus = Status.success;
  SpProfileCoreModel? sp_profileCore;
  List<String> commercialRegisterList = [];
  List<String> commercialRegisterListExtensions = [];
  String nationalIdAttachemnt = "";
  String storePhotoAttachemnt = "";
  String? nationalIdAttachemntExtension;
  String? storePhotoAttachemntExtension;
  String accountVerificationAttachemnt = "";
  String? accountVerificationAttachemntExtension;
  bool isUserSelected = true;
  int userId = 0;

  bool authenticated = false;
  SpProfileViewWebServices webServices = SpProfileViewWebServices();

  Future<void> FetchingProfileData(
      BuildContext context,
      ) async {
    print("loading");
    secondaryStatus = Status.loading;
    notifyListeners();
    print("start");
    APIResponse? response = await webServices.fetchSpProfileData();
    print("message");
    print(response?.status);
    print(response?.message);
    print(response?.item);
    notifyListeners();
    if (response?.status == 200) {
      sp_profileCore = SpProfileCoreModel.fromJson(response?.data);
      print("dataa");
      print("done");
      print(secondaryStatus);
      secondaryStatus = Status.success;
      notifyListeners();
    } else {
      print("erorrrrrr");
    }

    // try {
    //   print("start");
    //   APIResponse? response = await webServices.fetchHomeData();
    //   print("message");
    //   print(response?.message);
    //   if(response?.message == "Home") {
    //       homeCore = HomeCoreModel.fromJson(response?.data);
    //       print(homeCore);
    //       print("done");
    //       print(secondaryStatus);
    //       secondaryStatus = Status.success;
    //       notifyListeners();
    //   } else {
    //     print("erorrrrrr");
    //   }
    //   // print(response['status']);
    //   // if (response['message'] == "Success") {
    //   //   homeCore = HomeCoreModel.fromJson(response['data']);
    //   //   print(homeCore);
    //   //   print("done");
    //   //   print(secondaryStatus);
    //   //   secondaryStatus = Status.success;
    //   //   notifyListeners();
    //   // } else if (response['status'] == 400) {
    //   //   secondaryStatus = Status.failed;
    //   //   notifyListeners();
    //   // } else {
    //   //   secondaryStatus = Status.failed;
    //   //   notifyListeners();
    //   // }
    // } catch (e, stack) {
    //   secondaryStatus = Status.failed;
    //   notifyListeners();
    // }
  }



  Future<bool> editProfileInfo(
      String name,
      String email,
      String phone,
      List<City> cities,
      List<Category> categories,
      BuildContext context,
      ) async {
    status = Status.loading;
    notifyListeners();
    try {
      Map<String, String> body = {
        "name": name,
        "email": email,
        "phone": phone,
        for (int i = 0; i < cities.length; i++)
          "cities[$i]": cities[i].id.toString(),
        for (int i = 0; i < categories.length; i++)
          "categories[$i]": categories[i].id.toString(),


      };

      APIResponse response = await webServices.spRegisterStore(
          body,
          storePhotoAttachemnt,
          nationalIdAttachemnt);
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

  Future<void> pickStoreFiles() async {
    storePhotoAttachemnt = "";
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'pdf', 'jpg', 'PNG'],
    );
    if (result != null) {
      storePhotoAttachemnt = result.files.single.path!;
      storePhotoAttachemntExtension = result.files.single.extension!;
      notifyListeners();
    } else {
      storePhotoAttachemnt = "";
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
}