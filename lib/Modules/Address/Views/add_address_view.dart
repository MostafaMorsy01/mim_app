import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Address/Views/Mobile/add_address_mobile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AddAddressView extends StatelessWidget {
  const AddAddressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: AddAddressMobileView(),
      tablet: AddAddressMobileView(),
    );
  }
}
