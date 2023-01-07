

import 'package:flutter/cupertino.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'Mobile/sp_order_list_mobile_view.dart';


class SpOrderListView extends StatelessWidget {
  static const routeName = '/sp_my_orders';
  const SpOrderListView({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile:  SpOrderListMobileView(),
      tablet:  SpOrderListMobileView(),
    );
  }
}