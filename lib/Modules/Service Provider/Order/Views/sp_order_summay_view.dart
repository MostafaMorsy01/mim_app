import 'package:flutter/cupertino.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'Mobile/sp_order_summary_mobile_view.dart';

class SpOrderSummaryView extends StatelessWidget {
  final int? product_id;
  const SpOrderSummaryView({Key? key, required this.product_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile:  SpOrderDetailsMobileView(product_id: product_id),
      tablet:  SpOrderDetailsMobileView(product_id: product_id),
    );
  }
}