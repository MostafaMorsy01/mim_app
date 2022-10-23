import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'Mobile/customer_reviews_mobile_view.dart';

class SpCustomerReviewsView extends StatelessWidget {
  static const routeName = '/sp_customer_reviews';
  const SpCustomerReviewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const SpCustomerReviewsMobileView(),
      tablet: const SpCustomerReviewsMobileView(),
    );
  }
}
