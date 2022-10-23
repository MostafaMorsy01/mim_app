import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Model/sp_categories_core_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Model/sp_specification_core_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Services/sp_categories_web_services.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Services/sp_specification_web_service.dart';

import '../../../../Constants/app_enums.dart';
import '../../../../Models/api_response_model.dart';
import '../../../../Models/user_model.dart';

class CategoriesViewModel with ChangeNotifier {
  User? user;
  String? accessToken;
  Status status = Status.success;
  Status secondaryStatus = Status.success;
  CategoriesCoreModel? catCore;
  List<String> commercialRegisterList = [];
  List<String> commercialRegisterListExtensions = [];
  String nationalIdAttachemnt = "";
  String? nationalIdAttachemntExtension;
  String accountVerificationAttachemnt = "";
  String? accountVerificationAttachemntExtension;
  bool isUserSelected = true;
  int userId = 0;
  bool authenticated = false;
  CategoriesWebServices webServices = CategoriesWebServices();

  Future<void> categoriesFetchingData(
      BuildContext context,
      ) async {
    print("loading");
    secondaryStatus = Status.loading;
    notifyListeners();
    print("start");
    APIResponse? response = await webServices.fetchCategoriessData();
    print("message");
    print(response?.status);
    print(response?.message);
    print(response?.item);
    notifyListeners();

    if (response?.status == 200) {
      catCore = CategoriesCoreModel.fromJson(response?.data);
      print(catCore);
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