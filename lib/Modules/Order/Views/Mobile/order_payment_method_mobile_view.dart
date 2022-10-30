import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../CommonWidget/main_button.dart';
import '../../../../CommonWidget/title_appbar.dart';
import '../../../../Constants/app_colors.dart';
import '../../../../Constants/app_fonts.dart';
import '../../../../Localization/app_localization.dart';
import '../../../Authentication/Widgets/selectable_circle_widget.dart';
import '../../../BottomNavbar/Views/bottom_navbar_view.dart';
import '../../ViewModel/order_view_model.dart';
import '../order_address_view.dart';
import 'order_address_mobile_view.dart';

class OrderPaymentMobileView extends StatefulWidget {
  const OrderPaymentMobileView({Key? key}) : super(key: key);

  @override
  State<OrderPaymentMobileView> createState() => _OrderPaymentMobileViewState();
}

class _OrderPaymentMobileViewState extends State<OrderPaymentMobileView> {
  late OrderViewModel orderViewModel;
  bool isVisible1 = false;
  bool isSelected = false;
  int? payment_id;
  int? selectedIndex;

  @override
  void initState() {
    // TODO: implement initState

    orderViewModel = Provider.of<OrderViewModel>(context, listen: false);

    Future(() async {
      await orderViewModel.paymentMethodData(context);
    });

    callThisMethod(isVisible1);
    super.initState();
  }

  void callThisMethod(bool isVisible) {
    debugPrint('_AddressScreen.callThisMethod: isVisible: ${isVisible}');
    // addressViewModel.addressFetchingData(context);
  }
  
  @override
  Widget build(BuildContext context) {
    orderViewModel = Provider.of<OrderViewModel>(context, listen: true);
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

                ...List.generate(
                  orderViewModel.paymentCore?.paymentTypes?.length ??
                      0,
                      (index) =>
                          InkWell(
                            onTap: (){

                              setState(() {
                                selectedIndex = index;
                                print(selectedIndex);
                                payment_id = orderViewModel.paymentCore?.paymentTypes?[index].id;
                                print(payment_id);
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top:20.0,right: 20.0, ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: selectedIndex == index ? AppColors.blue1 : AppColors.white,
                                      border: Border.all(color: AppColors.blue1, width: 2.0),
                                    ),
                                    padding: const EdgeInsets.all(8.5),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: SelectableText(
                                      "${orderViewModel.paymentCore?.paymentTypes?[index].name ?? ""} ",
                                      style: const TextStyle(
                                          fontFamily: AppFonts.cairoFontRegular, fontSize: 17.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top:10.0,right: 20.0, ),
                          //   child: ListTile(
                          //     title:  Text('${orderViewModel.paymentCore?.paymentTypes?[index].name ?? ""} ',style: const TextStyle(
                          //         fontFamily: AppFonts.cairoFontRegular, fontSize: 17.0),),
                          //     leading: Radio(
                          //       value: orderViewModel.paymentCore?.paymentTypes?[index].id,
                          //       groupValue: payment_id,
                          //       onChanged: (value) {
                          //         setState(() {
                          //           print(value);
                          //           // isSelected = true;
                          //           payment_id = value!;
                          //         });
                          //       },
                          //     ),
                          //   ),
                          // ),

                ),
                SizedBox(
                  height: deviceSize.height * 0.5,
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: MainButton(
                    text: getTranslated(context, "complete_payment"),
                    width: deviceSize.width * 0.9,
                    onPressed: () {
                      if(selectedIndex != null){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderAddressView(payment_id: payment_id ?? 1 ,) ));
                      }

                    },
                  ),
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
