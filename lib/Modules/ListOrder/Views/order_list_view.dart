

import 'package:flutter/cupertino.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'Mobile/order_list_mobile_vieew.dart';

class OrderListView extends StatelessWidget {
  const OrderListView({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile:  OrderListMobileView(),
      tablet:  OrderListMobileView(),
    );
  }
}