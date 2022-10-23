import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Authentication/Views/Mobile/forget_password_mobile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ForgetPasswordView extends StatelessWidget {
  static const routeName = '/forget_password';
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    return ScreenTypeLayout(
      mobile: ForgetPasswordMobileView(
        userType: arguments['userType'],
      ),
      tablet: ForgetPasswordMobileView(
        userType: arguments['userType'],
      ),
    );
  }
}
