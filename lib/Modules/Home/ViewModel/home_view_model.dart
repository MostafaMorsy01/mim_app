import 'package:flutter/material.dart';
import 'package:meem_app/Models/HomeModel/HomeCoreModel.dart';
import 'package:meem_app/Modules/Home/Services/home_web_service.dart';

import '../../../Constants/app_enums.dart';
import '../../../Models/HomeModel/HomeFeaturedCategoryModel.dart';
import '../../../Models/api_response_model.dart';
import '../../../Models/user_model.dart';

class HomeViewModel with ChangeNotifier {
  User? user;
  String? accessToken;
  Status status = Status.success;
  Status secondaryStatus = Status.success;
  HomeCoreModel? homeCore;
  List<HomeFeaturedCategoryModel>?  featuredCore;
  List<String> commercialRegisterList = [];
  List<String> commercialRegisterListExtensions = [];
  String nationalIdAttachemnt = "";
  String? nationalIdAttachemntExtension;
  String accountVerificationAttachemnt = "";
  String? accountVerificationAttachemntExtension;
  bool isUserSelected = true;
  int userId = 0;
  bool authenticated = false;
  HomeWebServices webServices = HomeWebServices();

  Future<void> homeFetchingData(
    BuildContext context,
  ) async {
    print("loading");
    secondaryStatus = Status.loading;
    notifyListeners();
    print("start");
    APIResponse? response = await webServices.fetchHomeData();
    print("message");
    print(response?.status);
    notifyListeners();
    if (response?.status == 200) {
      homeCore = HomeCoreModel.fromJson(response?.data);
      featuredCore = homeCore?.homeFeatureCategory;
      print("Categories");
      print(featuredCore);
      print(homeCore);
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
}
