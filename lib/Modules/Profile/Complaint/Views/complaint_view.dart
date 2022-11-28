import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Profile/Views/Mobile/profile_mobile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'Mobile/complaint_mobile_view.dart';

class ComplaintView extends StatelessWidget {
  static const routeName = '/profile';
  const ComplaintView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const ComplaintMobileView(),
      tablet: const ComplaintMobileView(),
    );
  }
}
