import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Cart/Views/Mobile/my_cart_mobile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MyCartView extends StatelessWidget {
  static const routeName = '/my_cart';
  const MyCartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const MyCartMobileView(),
      tablet: const MyCartMobileView(),
    );
  }
}
