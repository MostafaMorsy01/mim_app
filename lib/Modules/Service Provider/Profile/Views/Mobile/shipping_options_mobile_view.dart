import 'package:flutter/material.dart';
import 'package:meem_app/CommonWidget/custom_checkbox.dart';
import 'package:meem_app/CommonWidget/main_button.dart';
import 'package:meem_app/CommonWidget/title_appbar.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Modules/Service%20Provider/Profile/Model/shipping_method_core_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Profile/ViewModel/shipping_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../CommonWidget/toast.dart';
import '../../../../../Constants/app_enums.dart';

class SpShippingOptionsMobileView extends StatefulWidget {
  const SpShippingOptionsMobileView({Key? key}) : super(key: key);

  @override
  State<SpShippingOptionsMobileView> createState() =>
      _SpShippingOptionsMobileViewState();
}

class _SpShippingOptionsMobileViewState
    extends State<SpShippingOptionsMobileView> {
  late ShippingMethodViewModel shippingMethodViewModel;
  List<ShippingCompany>? selectedShippingMethods = [];

  @override
  void initState() {
    // TODO: implement initState
    shippingMethodViewModel = Provider.of<ShippingMethodViewModel>(context, listen: false);

    Future(() async {
      await shippingMethodViewModel.shippingMethodData(context);
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: TitleAppBar(
          title: getTranslated(context, "shipping_methods"),
        ),
        elevation: 0,
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.05),
              child: Text(
                getTranslated(context, "choose_shipping_method"),
                style: const TextStyle(
                    height: 1.6,
                    color: AppColors.black,
                    fontFamily: AppFonts.cairoFontLight,
                    fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.05),
              child: Text(
                getTranslated(context, "official_shipping"),
                style: const TextStyle(
                    height: 1.6,
                    color: AppColors.black,
                    fontFamily: AppFonts.cairoFontRegular,
                    fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            shippingMethodViewModel.secondaryStatus == Status.loading ||
                shippingMethodViewModel.shippingCore == null
                ? Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            )
                : Column(
              children: [
                ...List.generate(
                  shippingMethodViewModel.shippingCore?.shippingCompany?.length ?? 0,
                      (index) => CustomCheckbox(
                    text: shippingMethodViewModel
                        .shippingCore?.shippingCompany?[index].name ??
                        "",
                    width: deviceSize.width * 0.9,
                    checkboxSelected: shippingMethodViewModel
                        .shippingCore?.shippingCompany?[index].selected ??
                        false,
                    onChanged: (selected) {
                      setState(() {
                        shippingMethodViewModel
                            .shippingCore?.shippingCompany?[index]
                            .selected = !(shippingMethodViewModel
                            .shippingCore?.shippingCompany?[index].selected ??
                            false);
                        if (selected) {
                          selectedShippingMethods?.add(shippingMethodViewModel
                              .shippingCore!.shippingCompany![index]);
                        } else {
                          selectedShippingMethods?.remove(shippingMethodViewModel
                              .shippingCore?.shippingCompany?[index]);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            const Spacer(),
            shippingMethodViewModel.status == Status.loading
                ? const CircularProgressIndicator(
              color: AppColors.primary,
            )
                : MainButton(
                text: getTranslated(context, "save"),
                width: deviceSize.width * 0.9,
                onPressed: () async{
                  bool result = await shippingMethodViewModel.addShipping(
                      selectedShippingMethods!,
                      context);

                  if (result) {
                    toastAppSuccess(
                        "Shipping Method Added Successfully",
                        contest: context);
                  } else {
                    toastAppErr(
                        "Shipping Method does not add Successfully ",
                        contest: context);
                  }
                }),
            const SizedBox(
              height: 20,
            ),
          ]),
    );
  }
}

class PaymentOptionWidget extends StatefulWidget {
  final String name;
  final String image;
  final Function onSelected;
  const PaymentOptionWidget({
    Key? key,
    required this.name,
    required this.image,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<PaymentOptionWidget> createState() => _PaymentOptionWidgetState();
}

class _PaymentOptionWidgetState extends State<PaymentOptionWidget> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    double width = (deviceSize.width * 0.9 * 0.25) - 10;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: deviceSize.width * 0.05, vertical: 5.0),
      child: Row(
        children: [
          Checkbox(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              value: true,
              onChanged: (_) {
                setState(() {
                  // widget.checkboxSelected = !widget.checkboxSelected;
                });
              }),
          const SizedBox(
            width: 5.0,
          ),
          Container(
            width: width,
            height: width * 0.65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: AppColors.white,
              border: Border.all(color: AppColors.grey208),
            ),
            child: Image.asset(
              widget.image,
            ),
          ),
          const SizedBox(
            width: 5.0,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SelectableText(
              widget.name,
              style: const TextStyle(
                  fontFamily: AppFonts.cairoFontMedium, fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
