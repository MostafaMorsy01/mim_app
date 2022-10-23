import 'package:flutter/material.dart';
import 'package:meem_app/CommonWidget/main_button.dart';
import 'package:meem_app/CommonWidget/title_appbar.dart';
import 'package:meem_app/Constants/app_assets.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';

class SpPaymentOptionsMobileView extends StatefulWidget {
  const SpPaymentOptionsMobileView({Key? key}) : super(key: key);

  @override
  State<SpPaymentOptionsMobileView> createState() =>
      _SpPaymentOptionsMobileViewState();
}

class _SpPaymentOptionsMobileViewState
    extends State<SpPaymentOptionsMobileView> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: TitleAppBar(
          title: getTranslated(context, "payment_methods"),
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
                getTranslated(context, "choose_payment_method"),
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
                getTranslated(context, "payment_method"),
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
            PaymentOptionWidget(
              name: getTranslated(context, "visa"),
              image: AppAssets.visaLogo,
              onSelected: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            PaymentOptionWidget(
              name: getTranslated(context, "mastercard"),
              image: AppAssets.mastercardLogo,
              onSelected: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            PaymentOptionWidget(
              name: getTranslated(context, "paypal"),
              image: AppAssets.paypalLogo,
              onSelected: () {},
            ),
            const Spacer(),
            MainButton(
                text: getTranslated(context, "save"),
                width: deviceSize.width * 0.9,
                onPressed: () {}),
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
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                side: MaterialStateBorderSide.resolveWith(
                  (states) =>
                      const BorderSide(width: 1.0, color: AppColors.primary),
                ),
              ),
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
