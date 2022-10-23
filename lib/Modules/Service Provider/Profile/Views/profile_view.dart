import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'Mobile/profile_mobile_view.dart';

class SpProfileView extends StatelessWidget {
  static const routeName = '/sp_profile';
  const SpProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const SpProfileMobileView(),
      tablet: const SpProfileMobileView(),
    );
  }
}
