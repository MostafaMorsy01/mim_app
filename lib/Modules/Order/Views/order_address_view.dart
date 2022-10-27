import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'Mobile/order_address_mobile_view.dart';
import 'Mobile/order_payment_method_mobile_view.dart';

class OrderAddressView extends StatelessWidget {
  const OrderAddressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const OrderAddressMobileView(),
      tablet: const OrderAddressMobileView(),
    );
  }
}
