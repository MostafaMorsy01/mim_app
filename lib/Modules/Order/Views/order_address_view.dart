import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'Mobile/order_address_mobile_view.dart';
import 'Mobile/order_payment_method_mobile_view.dart';

class OrderAddressView extends StatelessWidget {
  final int payment_id;
  const OrderAddressView({Key? key, required this.payment_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile:  OrderAddressMobileView(payment_id: payment_id,),
      tablet:  OrderAddressMobileView(payment_id: payment_id,),
    );
  }
}
