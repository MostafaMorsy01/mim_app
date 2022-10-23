import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'Mobile/signup_mobile_view.dart';

class SignupView extends StatelessWidget {
  static const routeName = '/signup';
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const SignupMobileView(),
      tablet: const SignupMobileView(),
    );
  }
}
