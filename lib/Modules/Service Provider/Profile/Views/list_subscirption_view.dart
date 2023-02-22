import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'Mobile/list_subscription_mobile_view.dart';
import 'Mobile/subscription_mobile_view.dart';

class SpListSubscriptionView extends StatelessWidget {
  static const routeName = '/sp_list_subscription';
  const SpListSubscriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const SpListSubscriptionMobileView(),
      tablet: const SpListSubscriptionMobileView(),
    );
  }
}
