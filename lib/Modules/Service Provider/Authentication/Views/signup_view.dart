import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Service%20Provider/Authentication/Views/Mobile/signup_mobile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SpSignupView extends StatelessWidget {
  static const routeName = '/sp_signup';
  const SpSignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const SpSignupMobileView(),
      tablet: const SpSignupMobileView(),
    );
  }
}
