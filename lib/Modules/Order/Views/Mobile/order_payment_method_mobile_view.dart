import 'package:flutter/material.dart';

import '../../../../CommonWidget/main_button.dart';
import '../../../../CommonWidget/title_appbar.dart';
import '../../../../Constants/app_fonts.dart';
import '../../../../Localization/app_localization.dart';
import '../../../Authentication/Widgets/selectable_circle_widget.dart';
import '../../../BottomNavbar/Views/bottom_navbar_view.dart';

class OrderPaymentMobileView extends StatefulWidget {
  const OrderPaymentMobileView({Key? key}) : super(key: key);

  @override
  State<OrderPaymentMobileView> createState() => _OrderPaymentMobileViewState();
}

class _OrderPaymentMobileViewState extends State<OrderPaymentMobileView> {
  bool isSelected = true;
  
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: TitleAppBarWithNavigation(
          title: getTranslated(context, "payment_methods"),
          onNav: (){
            Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) =>  BottomNavbarView()));

          },
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          SelectableText(
            getTranslated(context, "payment_title"),
            style: const TextStyle(
                fontFamily: AppFonts.cairoFontRegular, fontSize: 20),
          ),

          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top:80.0,right: 20.0),
                  child: SelectableCircleWidget(
                    deviceSize: deviceSize,
                    isSelected: isSelected,
                    title: getTranslated(context, "cash_payment"),
                    onPressed: () {
                      setState(() {
                        isSelected = true;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: deviceSize.height * 0.4,
                ),
                MainButton(
                  text: getTranslated(context, "complete_payment"),
                  width: deviceSize.width * 0.9,
                  onPressed: () {
                    // Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new OrderPaymentView()));
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
