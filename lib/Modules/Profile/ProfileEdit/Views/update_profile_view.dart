import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Profile/Views/Mobile/profile_mobile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'Mobile/update_profile_mobile_view.dart';

class UpdateProfileView extends StatelessWidget {
  static const routeName = '/profile';
  const UpdateProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const UpdateProfileMobileView(),
      tablet: const UpdateProfileMobileView(),
    );
  }
}
