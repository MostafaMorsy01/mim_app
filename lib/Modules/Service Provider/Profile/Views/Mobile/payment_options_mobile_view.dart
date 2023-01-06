import 'package:flutter/material.dart';
import 'package:meem_app/CommonWidget/main_button.dart';
import 'package:meem_app/CommonWidget/title_appbar.dart';
import 'package:meem_app/Constants/app_assets.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Modules/Service%20Provider/Profile/Model/payment_method_core_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Profile/ViewModel/payment_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../CommonWidget/custom_checkbox.dart';
import '../../../../../CommonWidget/toast.dart';
import '../../../../../Constants/app_enums.dart';

class SpPaymentOptionsMobileView extends StatefulWidget {
  const SpPaymentOptionsMobileView({Key? key}) : super(key: key);

  @override
  State<SpPaymentOptionsMobileView> createState() =>
      _SpPaymentOptionsMobileViewState();
}

class _SpPaymentOptionsMobileViewState
    extends State<SpPaymentOptionsMobileView> {
  late PaymentViewModel paymentViewModel;
  List<PaymentTypes>? selectedPaymentMethods = [];

  @override
  void initState() {
    // TODO: implement initState
    paymentViewModel = Provider.of<PaymentViewModel>(context, listen: false);

    Future(() async {
      await paymentViewModel.paymentMethodData(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    paymentViewModel = Provider.of<PaymentViewModel>(context, listen: true);
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
            paymentViewModel.secondaryStatus == Status.loading ||
                    paymentViewModel.paymentCore == null
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  )
                : Column(
                    children: [
                      ...List.generate(
                        paymentViewModel.paymentCore?.paymentTypes?.length ?? 0,
                        (index) => CustomCheckbox(
                          text: paymentViewModel
                                  .paymentCore?.paymentTypes?[index].name ??
                              "",
                          width: deviceSize.width * 0.9,
                          checkboxSelected: paymentViewModel
                                  .paymentCore?.paymentTypes?[index].selected ??
                              false,
                          onChanged: (selected) {
                            setState(() {
                              paymentViewModel.paymentCore?.paymentTypes?[index]
                                  .selected = !(paymentViewModel.paymentCore
                                      ?.paymentTypes?[index].selected ??
                                  false);
                              if (selected) {
                                selectedPaymentMethods?.add(paymentViewModel
                                    .paymentCore!.paymentTypes![index]);
                              } else {
                                selectedPaymentMethods?.remove(paymentViewModel
                                    .paymentCore?.paymentTypes?[index]);
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
            const Spacer(),
            paymentViewModel.status == Status.loading
                ? const CircularProgressIndicator(
                    color: AppColors.primary,
                  )
                : MainButton(
                    text: getTranslated(context, "save"),
                    width: deviceSize.width * 0.9,
                    onPressed: () async{
                      bool result = await paymentViewModel.addPayment(
                          selectedPaymentMethods!,
                          context);

                      if (result) {
                        toastAppSuccess(
                            "Payment Method Added Successfully",
                            contest: context);
                      } else {
                        toastAppErr(
                            "Payment Method does not add Successfully ",
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
