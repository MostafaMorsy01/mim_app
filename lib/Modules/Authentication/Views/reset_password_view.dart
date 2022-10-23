import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Authentication/Views/Mobile/reset_password_mobile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResetPasswordView extends StatelessWidget {
  static const routeName = '/reset_password';
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    return ScreenTypeLayout(
      mobile: ResetPasswordMobileView(
        userType: arguments['userType'],
      ),
      tablet: ResetPasswordMobileView(
        userType: arguments['userType'],
      ),
    );
  }
}
