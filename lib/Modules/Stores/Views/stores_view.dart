import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Stores/Views/Mobile/stores_mobile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class StoresView extends StatelessWidget {
  static const routeName = '/stores';
  const StoresView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const StoresMobileView(),
      tablet: const StoresMobileView(),
    );
  }
}
