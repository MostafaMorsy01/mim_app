import 'package:flutter/material.dart';

import '../../../Constants/app_enums.dart';
import '../../../Models/api_response_model.dart';
import '../../../Models/user_model.dart';
import '../../../Services/check_api_status_service.dart';
import '../Service/add_to_cart_web_service.dart';
import '../Service/update_cart_web_service.dart';

class UpdateCartViewModel with ChangeNotifier {
  User? user;
  String? accessToken;
  UpdateCartWebServices webServices = UpdateCartWebServices();
  Status status = Status.success;
  Status secondaryStatus = Status.success;
  // SpSignupListData? spSignupListData;
  List<String> commercialRegisterList = [];
  List<String> commercialRegisterListExtensions = [];
  String nationalIdAttachemnt = "";
  String? nationalIdAttachemntExtension;
  String accountVerificationAttachemnt = "";
  String? accountVerificationAttachemntExtension;
  bool isUserSelected = true;
  int userId = 0;
  bool authenticated = false;

  Future<bool> updateCart(
      int qty,
      int itemId,
      BuildContext context,
      ) async {
    status = Status.loading;
    notifyListeners();
    try {
      Map<String, dynamic> body = {
        "quantity": qty,
        "item_id" : itemId

      };
      APIResponse response = await webServices.updateCart(body);
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


}
