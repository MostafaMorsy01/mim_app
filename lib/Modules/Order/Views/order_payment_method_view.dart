import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'Mobile/order_payment_method_mobile_view.dart';

class OrderPaymentView extends StatelessWidget {
  const OrderPaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const OrderPaymentMobileView(),
      tablet: const OrderPaymentMobileView(),
    );
  }
}
