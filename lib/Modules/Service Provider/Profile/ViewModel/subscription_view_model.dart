
import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Address/Model/address_core_model.dart';
import 'package:meem_app/Modules/Address/Service/address_web_service.dart';
import 'package:meem_app/Modules/Favourite/Service/list_favourite_web_service.dart';
import 'package:meem_app/Modules/Order/Model/payment_method_core_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Profile/Model/subscription_core_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Profile/Services/payment_method_web_service.dart';
import 'package:meem_app/Modules/Service%20Provider/Profile/Services/subscirption_web_service.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Model/Sp_Product_core_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Services/sp_products_web_services.dart';

import '../../../../Constants/app_enums.dart';
import '../../../../Models/api_response_model.dart';
import '../../../../Models/user_model.dart';
import '../../../../Services/check_api_status_service.dart';
import '../Model/list_subcription_core_model.dart';
import '../Model/payment_method_core_model.dart';



class SubscriptionViewModel with ChangeNotifier {
  User? user;
  String? accessToken;
  Status status = Status.success;
  Status secondaryStatus = Status.success;
  Status secondaryStatus1 = Status.success;
  // AddressCoreModel? addressCore;
  // AddAddress? addressCore1;
  // PaymentMethodCoreModel? paymentCore;
  StoreSubscriptionCoreModel? storeSubscriptionCoreModel;
  StoreListSubscriptionCoreModel? storeListSubscriptionCoreModel;
  // SpSignupListData? listData;
  String nationalIdAttachemnt = "";
  String? nationalIdAttachemntExtension;
  String accountVerificationAttachemnt = "";
  String? accountVerificationAttachemntExtension;
  bool isUserSelected = true;
  int userId = 0;

  bool authenticated = false;
  SubscriptionWebService webServices = SubscriptionWebService();

  Future<void> fetchStoreSubscription(
      BuildContext context,
      ) async {
    print("loading");
    secondaryStatus = Status.loading;
    notifyListeners();
    print("start");
    APIResponse? response = await webServices.fetchStoreSubscription();
    print("message");
    print(response?.status);
    print(response?.message);
    print(response?.item);
    notifyListeners();
    if (response?.status == 200) {
      storeSubscriptionCoreModel = StoreSubscriptionCoreModel.fromJson(response?.data);
      print("dataa");
      print("done");
      print(secondaryStatus);
      secondaryStatus = Status.success;
      notifyListeners();
    } else {
      print("erorrrrrr");
    }


  }

  Future<void> fetchListStoreSubscription(
      BuildContext context,
      ) async {
    print("loading");
    secondaryStatus = Status.loading;
    notifyListeners();
    print("start");
    APIResponse? response = await webServices.fetchListStoreSubscription();
    print("message");
    print(response?.status);
    print(response?.message);
    print(response?.item);
    notifyListeners();
    if (response?.status == 200) {
      storeListSubscriptionCoreModel = StoreListSubscriptionCoreModel.fromJson(response?.data);
      print("dataa");
      print("done");
      print(secondaryStatus);
      secondaryStatus = Status.success;
      notifyListeners();
    } else {
      print("erorrrrrr");
    }


  }
  Future<bool> addPayment(
      List<PaymentTypes> paymentMethods,
      BuildContext context,
      ) async {

    status = Status.loading;
    notifyListeners();
    try {
      Map<String, dynamic> body = {
        for (int i = 0; i < paymentMethods.length; i++)
          "payments_id[$i]": paymentMethods[i].id.toString(),

      };
      print(body);
      APIResponse response = await webServices.addPayment(body);
      //TODO: Change (Fix the status code problem)
      bool statusCodeCheck = checkStatusCode(context, response);

      if (statusCodeCheck) {
        // userId = response.item!;
        print("success");
        // addressCore1 = AddAddress.fromJson(response.data!);
        // print(addressCore1);
        status = Status.success;
        print(status);
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


// Future<bool> deleteAddress(
//     int address_id,
//     BuildContext context,
//     ) async {
//
//   status = Status.loading;
//   notifyListeners();
//   try {
//     Map<String, dynamic> body = {
//       "address_id": address_id,
//     };
//     print(body);
//     APIResponse response = await webServices.deleteAddress(body);
//     //TODO: Change (Fix the status code problem)
//     bool statusCodeCheck = checkStatusCode(context, response);
//
//     if (statusCodeCheck) {
//       // userId = response.item!;
//       print("success");
//       // addressCore1 = AddAddress.fromJson(response.data!);
//       // print(addressCore1);
//       status = Status.success;
//       print(status);
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


}