import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Cart/Service/delete_cart_item_web_Service.dart';

import '../../../Constants/app_enums.dart';
import '../../../Models/api_response_model.dart';
import '../../../Models/user_model.dart';
import '../../../Services/check_api_status_service.dart';
import '../Service/add_to_cart_web_service.dart';

class DeleteItemCartViewModel with ChangeNotifier {
  User? user;
  String? accessToken;
  DeleteCartItemWebServices webServices = DeleteCartItemWebServices();
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

  Future<bool> deleteFromCart(
      int productId,
      BuildContext context,
      ) async {
    status = Status.loading;
    notifyListeners();
    print("idd");
    print(productId);
    try {
      Map<String, dynamic> body = {
        "item_id": productId,

      };
      APIResponse response = await webServices.deleteFromCart(body);
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
