import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Address/Views/Mobile/add_address_mobile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../Models/sp_signup_list_data_model.dart';

class AddAddressView extends StatelessWidget {
  final SpSignupListData? listData;
  const AddAddressView({Key? key,required this.listData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: AddAddressMobileView(listData:listData ,),
      tablet: AddAddressMobileView(listData: listData,),
    );
  }
}
