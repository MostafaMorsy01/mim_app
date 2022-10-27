import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'Mobile/order_payment_method_mobile_view.dart';
import 'Mobile/order_sucess_mobile_view.dart';

class OrderSuccessView extends StatelessWidget {
  const OrderSuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const OrderSuccessMobileView(),
      tablet: const OrderSuccessMobileView(),
    );
  }
}
