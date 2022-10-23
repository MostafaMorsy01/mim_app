import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Authentication/Views/forget_password_view.dart';
import 'package:meem_app/Modules/Authentication/Views/login_view.dart';
import 'package:meem_app/Modules/Authentication/Views/phone_verification_view.dart';
import 'package:meem_app/Modules/Authentication/Views/reset_password_view.dart';
import 'package:meem_app/Modules/Authentication/Views/signup_view.dart.dart';
import 'package:meem_app/Modules/Products/Views/products_list_view.dart';

class AuthenticationNavigations {
  static void phoneVerificationNavigation(
      BuildContext context, String userType) {
    Navigator.of(context).pushNamed(PhoneVerificationView.routeName,
        arguments: {"userType": userType});
  }

  static void signupNavigation(BuildContext context) {
    Navigator.of(context).pushNamed(SignupView.routeName);
  }

  static void loginNavigation(BuildContext context) {
    Navigator.of(context).pop();
  }
  static void productsNavigation(BuildContext context, int productId) {
    Navigator.of(context).pushNamed(ProductsListView.routeName,
        arguments: {"productId": productId});
  }

  static void forgetPasswordNavigation(BuildContext context, String userType) {
    Navigator.of(context).pushNamed(ForgetPasswordView.routeName,
        arguments: {"userType": userType});
  }

  static void resetPasswordNavigation(BuildContext context, String userType) {
    Navigator.of(context).pushNamed(ResetPasswordView.routeName,
        arguments: {"userType": userType});
  }
}
