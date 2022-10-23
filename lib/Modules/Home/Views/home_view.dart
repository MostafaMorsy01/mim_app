import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Home/Views/Mobile/home_mobile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeView extends StatelessWidget {
  static const routeName = '/home';
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const HomeMobileView(),
      tablet: const HomeMobileView(),
    );
  }
}
