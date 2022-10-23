import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Internet/Views/Mobile/no_internet_mobile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NoInternetView extends StatelessWidget {
  static const routeName = '/no_internet';
  const NoInternetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const NoInternetMobileView(),
      tablet: const NoInternetMobileView(),
    );
  }
}
