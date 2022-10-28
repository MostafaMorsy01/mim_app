
import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Address/Model/address_core_model.dart';
import 'package:meem_app/Modules/Address/Service/address_web_service.dart';
import 'package:meem_app/Modules/Favourite/Service/list_favourite_web_service.dart';
import 'package:meem_app/Modules/Order/Model/order_summry_core_model.dart';
import 'package:meem_app/Modules/Order/Service/order_web_service.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Model/Sp_Product_core_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Services/sp_products_web_services.dart';

import '../../../../Constants/app_enums.dart';
import '../../../../Models/api_response_model.dart';
import '../../../../Models/user_model.dart';
import '../../../Models/sp_signup_list_data_model.dart';
import '../../../Services/check_api_status_service.dart';
import '../../Products/Model/product_core_model.dart';


class OrderViewModel with ChangeNotifier {
  User? user;
  String? accessToken;
  Status status = Status.success;
  Status secondaryStatus = Status.success;
  Status secondaryStatus1 = Status.success;
  AddressCoreModel? addressCore;
  AddAddress? addressCore1;
  // SpSignupListData? listData;
  OrderSummryCoreModel? orderSummryCoreModel;
  String nationalIdAttachemnt = "";
  String? nationalIdAttachemntExtension;
  String accountVerificationAttachemnt = "";
  String? accountVerificationAttachemntExtension;
  bool isUserSelected = true;
  int userId = 0;

  bool authenticated = false;
  OrderWebServices webServices = OrderWebServices();


  Future<bool> placeOrder(
      int address_id,
      int payment_type,
      BuildContext context,
      ) async {

    status = Status.loading;
    notifyListeners();
    try {
      Map<String, dynamic> body = {
        "address_id": address_id,
        "payment_type_id": payment_type,

      };
      print(body);
      APIResponse? response = await webServices.placeOrder(body);
      //TODO: Change (Fix the status code problem)
      bool statusCodeCheck = checkStatusCode(context, response!);

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


  Future<bool> orderSummary(
      int address_id,
      int payment_type,
      BuildContext context,
      ) async {

    status = Status.loading;
    notifyListeners();
    try {
      Map<String, dynamic> body = {
        "address_id": address_id,
        "payment_type_id": payment_type,
      };
      print(body);
      APIResponse response = await webServices.orderSummary(body);
      //TODO: Change (Fix the status code problem)
      bool statusCodeCheck = checkStatusCode(context, response);

      if (statusCodeCheck) {
        // userId = response.item!;
        print("success");
        orderSummryCoreModel = OrderSummryCoreModel.fromJson(response.data!);
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