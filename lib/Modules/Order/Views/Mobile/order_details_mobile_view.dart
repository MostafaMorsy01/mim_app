
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../CommonWidget/title_appbar.dart';
import '../../../../Localization/app_localization.dart';

class OrderDetailsMobileView extends StatefulWidget {
  final int payment_type;
  final int address_id;
  const OrderDetailsMobileView({Key? key, required this.payment_type, required this.address_id}) : super(key: key);

  @override
  State<OrderDetailsMobileView> createState() => _OrderDetailsMobileViewState();
}

class _OrderDetailsMobileViewState extends State<OrderDetailsMobileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: TitleAppBar(
          title: getTranslated(context, "order_review"),
        ),
        elevation: 0,
      ),
      body: Column(),
    );
  }
}
