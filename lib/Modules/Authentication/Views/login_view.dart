import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Authentication/Views/Mobile/login_mobile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginView extends StatelessWidget {
  static const routeName = '/login';
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: LoginMobileView(),
      tablet: LoginMobileView(),
    );
  }
}
