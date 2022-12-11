import 'package:flutter/material.dart';

import '../../../Constants/app_enums.dart';
import '../../../Models/api_response_model.dart';
import '../../../Models/user_model.dart';
import '../../../Services/check_api_status_service.dart';
import '../Service/add_to_cart_web_service.dart';

class AddToCartViewModel with ChangeNotifier {
  User? user;
  String? accessToken;
  AddToCartWebServices webServices = AddToCartWebServices();
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



  Future<bool> addToCart(
      int productId,
          List<int> specifications,
      List<int> values,
      BuildContext context,

      ) async {
    status = Status.loading;
    notifyListeners();
    print(specifications);
    print(values);
    try {
      Map<String, dynamic> body = {
        "product_id": productId,
        for (int i = 0; i < values.length; i++)
            for(int j = 0; j < specifications.length;j++)
              if(values[i] == 1)
                "specification_values[${values[i]}]": specifications[0].toString()
              else
                "specification_values[${values[i]}]": specifications[j].toString()

        ,




      };
      print(body);
      APIResponse response = await webServices.addToCart(body);
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
