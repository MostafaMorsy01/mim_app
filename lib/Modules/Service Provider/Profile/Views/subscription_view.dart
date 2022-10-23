import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'Mobile/subscription_mobile_view.dart';

class SpSubscriptionView extends StatelessWidget {
  static const routeName = '/sp_subscription';
  const SpSubscriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const SpSubscriptionMobileView(),
      tablet: const SpSubscriptionMobileView(),
    );
  }
}
