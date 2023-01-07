
import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Address/Model/address_core_model.dart';
import 'package:meem_app/Modules/Address/Service/address_web_service.dart';
import 'package:meem_app/Modules/Favourite/Service/list_favourite_web_service.dart';
import 'package:meem_app/Modules/ListOrder/Services/order_list_web_service.dart';
import 'package:meem_app/Modules/Order/Model/order_summry_core_model.dart';
import 'package:meem_app/Modules/Order/Model/payment_method_core_model.dart';
import 'package:meem_app/Modules/Order/Service/order_web_service.dart';
import 'package:meem_app/Modules/Service%20Provider/Order/Model/sp_order_summary_core_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Model/Sp_Product_core_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Services/sp_products_web_services.dart';

import '../../../../Constants/app_enums.dart';
import '../../../../Models/api_response_model.dart';
import '../../../../Models/user_model.dart';

import '../../../../Services/check_api_status_service.dart';
import '../Model/sp_order_list_core_model.dart';
import '../Services/sp_order_list_web_Service.dart';


class SpOrderListViewModel with ChangeNotifier {
  User? user;
  String? accessToken;
  Status status = Status.success;
  Status secondaryStatus = Status.success;
  Status secondaryStatus1 = Status.success;
  AddressCoreModel? addressCore;
  AddAddress? addressCore1;
  PaymentCoreModel? paymentCore;
  // SpSignupListData? listData;
  SpOrderSummryCoreModel? orderSummryCoreModel;
  SpOrderListCoreModel? orderListCoreModel;
  String nationalIdAttachemnt = "";
  String? nationalIdAttachemntExtension;
  String accountVerificationAttachemnt = "";
  String? accountVerificationAttachemntExtension;
  String? order_status;
  String? order_status1;
  bool isUserSelected = true;
  int userId = 0;

  bool authenticated = false;
  SpOrderListWebServices webServices = SpOrderListWebServices();


  Future<bool> listOrder(

      BuildContext context,
      ) async {
    orderListCoreModel = null;
    status = Status.loading;
    notifyListeners();
    try {
      Map<String, dynamic> body = {
        "status": order_status,

      };
      print(body);
      APIResponse? response = await webServices.orderList(body);
      //TODO: Change (Fix the status code problem)
      bool statusCodeCheck = checkStatusCode(context, response!);

      if (statusCodeCheck) {
        // userId = response.item!;
        print("success");
        // addressCore1 = AddAddress.fromJson(response.data!);
        // print(addressCore1);
        status = Status.success;
        orderListCoreModel = SpOrderListCoreModel.fromJson(response.data);
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


  Future<bool> changeOrderStatus(
      int order_id,
      BuildContext context,
      ) async {
    orderListCoreModel = null;
    status = Status.loading;
    notifyListeners();
    try {
      Map<String, dynamic> body = {
        "status": order_status1,
        "order_id": order_id

      };
      print(body);
      APIResponse? response = await webServices.changeOrderStatus(body);
      //TODO: Change (Fix the status code problem)
      bool statusCodeCheck = checkStatusCode(context, response!);

      if (statusCodeCheck) {
        // userId = response.item!;
        print("success");
        // addressCore1 = AddAddress.fromJson(response.data!);
        // print(addressCore1);
        status = Status.success;
        orderListCoreModel = SpOrderListCoreModel.fromJson(response.data);
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

  Future<void> orderSummary(
      int product_id,

      BuildContext context,
      ) async {

    status = Status.loading;
    notifyListeners();

    print("start");
    APIResponse? response = await webServices.orderSummary(product_id);
    print("message");
    print(response?.status);
    print(response?.message);
    print(response?.item);
    notifyListeners();
    if (response?.status == 200) {
      orderSummryCoreModel = SpOrderSummryCoreModel.fromJson(response.data);
      print("dataa");
      print(orderSummryCoreModel);
      print("done");
      print(secondaryStatus);
      secondaryStatus = Status.success;
      notifyListeners();
    } else {
      print("erorrrrrr");
    }
  }





}