import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'Mobile/shipping_options_mobile_view.dart';

class SpShippingOptionsView extends StatelessWidget {
  static const routeName = '/sp_shipping_options';
  const SpShippingOptionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const SpShippingOptionsMobileView(),
      tablet: const SpShippingOptionsMobileView(),
    );
  }
}
