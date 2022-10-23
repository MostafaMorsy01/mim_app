import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'Mobile/my_products_mobile_view.dart';

class SpMyProductsView extends StatelessWidget {
  static const routeName = '/sp_my_products';
  const SpMyProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const SpMyProductsMobileView(),
      tablet: const SpMyProductsMobileView(),
    );
  }
}
