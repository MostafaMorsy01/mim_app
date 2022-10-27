import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'Mobile/order_address_mobile_view.dart';
import 'Mobile/order_details_mobile_view.dart';
import 'Mobile/order_payment_method_mobile_view.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const OrderDetailsMobileView(),
      tablet: const OrderDetailsMobileView(),
    );
  }
}
