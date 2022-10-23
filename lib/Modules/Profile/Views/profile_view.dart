import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Profile/Views/Mobile/profile_mobile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProfileView extends StatelessWidget {
  static const routeName = '/profile';
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const ProfileMobileView(),
      tablet: const ProfileMobileView(),
    );
  }
}
