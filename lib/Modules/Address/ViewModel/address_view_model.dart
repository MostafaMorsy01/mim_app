
import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Address/Model/address_core_model.dart';
import 'package:meem_app/Modules/Address/Service/address_web_service.dart';
import 'package:meem_app/Modules/Favourite/Service/list_favourite_web_service.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Model/Sp_Product_core_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Services/sp_products_web_services.dart';

import '../../../../Constants/app_enums.dart';
import '../../../../Models/api_response_model.dart';
import '../../../../Models/user_model.dart';
import '../../../Models/sp_signup_list_data_model.dart';
import '../../../Services/check_api_status_service.dart';
import '../../Products/Model/product_core_model.dart';


class AddressViewModel with ChangeNotifier {
  User? user;
  String? accessToken;
  Status status = Status.success;
  Status secondaryStatus = Status.success;
  Status secondaryStatus1 = Status.success;
  AddressCoreModel? addressCore;
  AddAddress? addressCore1;
  // SpSignupListData? listData;
  String nationalIdAttachemnt = "";
  String? nationalIdAttachemntExtension;
  String accountVerificationAttachemnt = "";
  String? accountVerificationAttachemntExtension;
  bool isUserSelected = true;
  int userId = 0;

  bool authenticated = false;
  AddressWebServices webServices = AddressWebServices();

  Future<void> addressFetchingData(
      BuildContext context,
      ) async {
    print("loading");
    secondaryStatus = Status.loading;
    notifyListeners();
    print("start");
    APIResponse? response = await webServices.fetchAddressData();
    print("message");
    print(response?.status);
    print(response?.message);
    print(response?.item);
    notifyListeners();
    if (response?.status == 200) {
      addressCore = AddressCoreModel.fromJson(response?.data);
      print("dataa");
      print(addressCore);
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
  Future<bool> addAddress(
      String name,
      String area,
      int cityId,
      String street,
      String specialMark,
      BuildContext context,
      ) async {

    status = Status.loading;
    notifyListeners();
    try {
      Map<String, dynamic> body = {
        "name": name,
        "area": area,
        "city_id": cityId,
        "street": street,
        "specific_sign":specialMark,
      };
      print(body);
      APIResponse response = await webServices.addAddress(body);
      //TODO: Change (Fix the status code problem)
      bool statusCodeCheck = checkStatusCode(context, response);

      if (statusCodeCheck) {
        // userId = response.item!;
        print("success");
        addressCore1 = AddAddress.fromJson(response.data!);
        print(addressCore1);
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


  Future<bool> deleteAddress(
      int address_id,
      BuildContext context,
      ) async {

    status = Status.loading;
    notifyListeners();
    try {
      Map<String, dynamic> body = {
        "address_id": address_id,
      };
      print(body);
      APIResponse response = await webServices.deleteAddress(body);
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


}