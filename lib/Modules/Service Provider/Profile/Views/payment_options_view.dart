import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'Mobile/payment_options_mobile_view.dart';

class SpPaymentOptionsView extends StatelessWidget {
  static const routeName = '/sp_payment_options';
  const SpPaymentOptionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const SpPaymentOptionsMobileView(),
      tablet: const SpPaymentOptionsMobileView(),
    );
  }
}
