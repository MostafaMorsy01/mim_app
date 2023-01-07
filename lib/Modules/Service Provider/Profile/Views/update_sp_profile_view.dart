import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'Mobile/edit_profile_mobile_view.dart';
import 'Mobile/profile_mobile_view.dart';

class UpdateSpProfileView extends StatelessWidget {
  static const routeName = '/edit_profile';
  const UpdateSpProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const EditSpProfileMobileView(),
      tablet: const EditSpProfileMobileView(),
    );
  }
}
