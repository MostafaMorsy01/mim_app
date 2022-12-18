import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Localization/app_localization.dart';

import '../../../../CommonWidget/custom_text_field_widget.dart';
import '../../../../CommonWidget/main_button.dart';
import '../../../../Constants/app_assets.dart';
import '../../../../Constants/app_fonts.dart';
import '../../../../Services/text_field_validations.dart';
import '../../../BottomNavbar/Views/bottom_navbar_view.dart';
import '../../../ListOrder/Views/Mobile/order_list_mobile_vieew.dart';

class OrderSuccessMobileView extends StatefulWidget {
  const OrderSuccessMobileView({Key? key}) : super(key: key);

  @override
  State<OrderSuccessMobileView> createState() => _OrderSuccessMobileViewState();
}

class _OrderSuccessMobileViewState extends State<OrderSuccessMobileView> {
  TextEditingController rateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    rateController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final node = FocusScope.of(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:120.0),
                child: Center(
                  child: Image.asset(
                    AppAssets.order_success,
                    width: 200,
                    height: 300,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Center(
                  child: Text(
                    getTranslated(context, "order_done"),
                    style: const TextStyle(
                        fontFamily: AppFonts.cairoFontRegular,
                        color: AppColors.green2,
                        fontSize: 25),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Center(
                  child: Text(
                    getTranslated(context, "order_title"),
                    style: const TextStyle(
                        fontFamily: AppFonts.cairoFontRegular,
                        fontSize: 15),
                  ),
                ),
              ),
              CustomTextField(
                  deviceSize: deviceSize,
                  hint: getTranslated(context, "order_rate"),
                  controller: rateController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  icon: AppAssets.mailIcon,
                  validate: (_) {
                    return AppValidations.validateEmail(
                        rateController.text, context);
                  },
                  onEditingComplete: () {
                    node.nextFocus();
                  }),
              SizedBox(height: 100,),
              Padding(
                padding: const EdgeInsets.all( 8.0),
                child: MainButton(
                  text: getTranslated(context, "home"),
                  width: deviceSize.width * 0.9,
                  onPressed: () async {

                    Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) =>  BottomNavbarView()));



                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all( 8.0),
                child: MainButton1(
                  text: getTranslated(context, "my_orders"),
                  width: deviceSize.width * 0.9,
                  onPressed: () async {

                    Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) =>  OrderListMobileView()));



                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
