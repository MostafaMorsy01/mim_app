import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Authentication/Views/Mobile/phone_verification_mobile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PhoneVerificationView extends StatelessWidget {
  static const routeName = '/phone_verification';
  const PhoneVerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    return ScreenTypeLayout(
      mobile: PhoneVerificationMobileView(
        userType: arguments['userType'],
      ),
      tablet: PhoneVerificationMobileView(userType: arguments['userType']),
    );
  }
}
