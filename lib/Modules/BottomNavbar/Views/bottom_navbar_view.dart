import 'package:flutter/material.dart';
import 'package:meem_app/Modules/BottomNavbar/Views/Mobile/bottom_navbar_mobile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BottomNavbarView extends StatelessWidget {
  static const routeName = '/bottom_navbar';
  const BottomNavbarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const BottomNavbarMobileView(),
      tablet: const BottomNavbarMobileView(),
    );
  }
}
