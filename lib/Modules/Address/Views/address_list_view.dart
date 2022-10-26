import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'Mobile/adress_list_mobile_view.dart';


class AddressListView extends StatelessWidget {
  const AddressListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: AddressListMobileView(),
      tablet: AddressListMobileView(),
    );
  }
}
