
import 'package:flutter/material.dart';
import 'package:meem_app/Models/HomeModel/store_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Model/Sp_Product_core_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Services/sp_products_web_services.dart';

import '../../../../Constants/app_enums.dart';
import '../../../../Models/api_response_model.dart';
import '../../../../Models/user_model.dart';
import '../../../Services/check_api_status_service.dart';
import '../Model/product_core_model.dart';
import '../Services/product_web_service.dart';

class ProductsViewModel with ChangeNotifier {
  User? user;
  String? accessToken;
  Status status = Status.success;
  Status status1 = Status.success;
  Status secondaryStatus = Status.success;
  ProductCoreModel? productCore;
  ProductCoreModel? productCoreSearch;
  List<StoresModel?> storeCoreSearch = [];
  List<String> commercialRegisterList = [];
  List<String> commercialRegisterListExtensions = [];
  String nationalIdAttachemnt = "";
  String? nationalIdAttachemntExtension;
  String accountVerificationAttachemnt = "";
  String? accountVerificationAttachemntExtension;
  bool isUserSelected = true;
  int userId = 0;

  bool authenticated = false;
  ProductsWebServices webServices = ProductsWebServices();

  Future<void> ProductsFetchingData(
      BuildContext context,
      int? productsId,
      ) async {
    print("loading");
    secondaryStatus = Status.loading;
    notifyListeners();
    print("start");
    APIResponse? response = await webServices.fetchProductsData(productsId);
    print("message");
    print(response?.status);
    print(response?.message);
    print(response?.item);
    notifyListeners();
    if (response?.status == 200) {
      productCore = ProductCoreModel.fromJson(response?.data);
      print(productCore);
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


  Future<bool> searchForStoreProduct(
      String text,
      BuildContext context,
      ) async {
    // productCoreSearch = null;
    storeCoreSearch = [];
    status1 = Status.loading;
    notifyListeners();
    try {
      Map<String, dynamic> body = {
        "search": text,
        "type":"store"
      };
      print(body);
      APIResponse? response = await webServices.searchProductsData(body);
      //TODO: Change (Fix the status code problem)
      bool statusCodeCheck = checkStatusCode(context, response!);

      if (statusCodeCheck) {
        // userId = response.item!;
        print("success");
        // addressCore1 = AddAddress.fromJson(response.data!);
        // print(addressCore1);
        status1 = Status.success;
        storeCoreSearch = StoresModel.fromJson(response.data) as List<StoresModel?>;
        print(status1);
        notifyListeners();
        return true;
      } else {
        status1 = Status.failed;
        notifyListeners();
        return false;
      }
    } catch (error) {
      status1 = Status.failed;
      notifyListeners();
      return false;
    }
  }

}