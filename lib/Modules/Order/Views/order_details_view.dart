import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../Model/order_summry_core_model.dart';
import 'Mobile/order_address_mobile_view.dart';
import 'Mobile/order_details_mobile_view.dart';
import 'Mobile/order_payment_method_mobile_view.dart';

class OrderDetailsView extends StatelessWidget {
  final int payment_type;
  final int address_id;
  const OrderDetailsView({Key? key, required this.address_id, required this.payment_type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile:  OrderDetailsMobileView(payment_type: payment_type, address_id: address_id,),
      tablet:  OrderDetailsMobileView(payment_type: payment_type, address_id: address_id,),
    );
  }
}
