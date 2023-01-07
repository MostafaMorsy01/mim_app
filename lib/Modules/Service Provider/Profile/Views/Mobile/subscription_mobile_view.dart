import 'package:flutter/material.dart';
import 'package:meem_app/CommonWidget/custom_text_field_widget.dart';
import 'package:meem_app/CommonWidget/main_button.dart';
import 'package:meem_app/CommonWidget/secondary_button.dart';
import 'package:meem_app/CommonWidget/title_appbar.dart';
import 'package:meem_app/Constants/app_assets.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Modules/Service%20Provider/Profile/ViewModel/subscription_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../Constants/app_enums.dart';

class SpSubscriptionMobileView extends StatefulWidget {
  const SpSubscriptionMobileView({Key? key}) : super(key: key);

  @override
  State<SpSubscriptionMobileView> createState() =>
      _SpSubscriptionMobileViewState();
}

class _SpSubscriptionMobileViewState extends State<SpSubscriptionMobileView> {
  late SubscriptionViewModel subscriptionViewModel;

  @override
  void initState() {
    // TODO: implement initState
    subscriptionViewModel =
        Provider.of<SubscriptionViewModel>(context, listen: false);

    Future(() async {
      await subscriptionViewModel.fetchStoreSubscription(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: TitleAppBar(
          title: getTranslated(context, "subscription"),
          buttonTitle: getTranslated(context, "cancel_subscription"),
          buttonTitleColor: AppColors.searchBarClearRed,
        ),
        elevation: 0,
      ),
      body: subscriptionViewModel.secondaryStatus == Status.loading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            )
          : SubscriptionWidget(
              validSubscription: true,
              message:
                  subscriptionViewModel.storeSubscriptionCoreModel?.message ??
                      "",
              startDate: subscriptionViewModel.storeSubscriptionCoreModel
                      ?.currentSubscription?.startDate ??
                  "",
              endDate: subscriptionViewModel.storeSubscriptionCoreModel
                      ?.currentSubscription?.endDate ??
                  "",
            ),
    );
  }
}

class SubscriptionWidget extends StatefulWidget {
  final bool validSubscription;
  final String startDate;
  final String endDate;
  final String message;

  const SubscriptionWidget(
      {Key? key,
      required this.validSubscription,
      required this.message,
      required this.endDate,
      required this.startDate})
      : super(key: key);

  @override
  State<SubscriptionWidget> createState() => _SubscriptionWidgetState();
}

class _SubscriptionWidgetState extends State<SubscriptionWidget> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        Container(
          height: 80,
          margin: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.05),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: widget.validSubscription
                ? AppColors.green3
                : AppColors.searchBarClearRed,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  widget.message,
                  style: const TextStyle(
                      height: 1.6,
                      color: AppColors.white,
                      fontFamily: AppFonts.cairoFontRegular,
                      fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),

            ],
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslated(context, "subscription_start_date"),
                style: const TextStyle(
                    height: 1.6,
                    color: AppColors.black,
                    fontFamily: AppFonts.cairoFontRegular,
                    fontSize: 18),
              ),
               Text(
                widget.startDate,
                style: TextStyle(
                    height: 1.6,
                    color: AppColors.black,
                    fontFamily: AppFonts.cairoFontLight,
                    fontSize: 15),
              ),
              const SizedBox(height: 30.0),
              Text(
                getTranslated(context, "subscription_end_date"),
                style: TextStyle(
                    height: 1.6,
                    color: widget.validSubscription
                        ? AppColors.black
                        : AppColors.searchBarClearRed,
                    fontFamily: AppFonts.cairoFontRegular,
                    fontSize: 18),
              ),
              Text(
                widget.endDate,
                style: TextStyle(
                    height: 1.6,
                    color: widget.validSubscription
                        ? AppColors.black
                        : AppColors.searchBarClearRed,
                    fontFamily: AppFonts.cairoFontLight,
                    fontSize: 15),
              ),
            ],
          ),
        ),
        const Spacer(),
        Align(
          alignment: Alignment.center,
          child: SecondaryButton(
              text: getTranslated(context, "renew_subscription"),
              width: deviceSize.width * 0.9,
              onPressed: () {}),
        ),
        const SizedBox(
          height: 20.0,
        )
      ],
    );
  }
}

class NoSubscriptionWidget extends StatefulWidget {
  const NoSubscriptionWidget({Key? key}) : super(key: key);

  @override
  State<NoSubscriptionWidget> createState() => _NoSubscriptionWidgetState();
}

class _NoSubscriptionWidgetState extends State<NoSubscriptionWidget> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          const StoreSubscriptionCard(),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: deviceSize.width * 0.9,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                getTranslated(context, "enter_your_payment_info"),
                style: const TextStyle(
                    height: 1.6,
                    color: AppColors.black,
                    fontFamily: AppFonts.cairoFontRegular,
                    fontSize: 18),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: deviceSize.width * 0.9,
            child: Row(
              children: [
                PaymentMethodCard(isSelected: true, image: AppAssets.visaLogo),
                const SizedBox(
                  width: 10.0,
                ),
                PaymentMethodCard(
                    isSelected: false, image: AppAssets.mastercardLogo),
                const SizedBox(
                  width: 10.0,
                ),
                PaymentMethodCard(
                    isSelected: false, image: AppAssets.paytabsLogo),
                const SizedBox(
                  width: 10.0,
                ),
                PaymentMethodCard(
                    isSelected: false, image: AppAssets.paypalLogo),
                const SizedBox(
                  width: 10.0,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          CustomTextField(
              deviceSize: deviceSize,
              hint: getTranslated(context, "card_name_holder"),
              controller: TextEditingController(),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              icon: "",
              validate: (_) {},
              onEditingComplete: () {}),
          CustomTextField(
              deviceSize: deviceSize,
              hint: getTranslated(context, "card_number"),
              controller: TextEditingController(),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              icon: "",
              validate: (_) {},
              onEditingComplete: () {}),
          CustomTextField(
              deviceSize: deviceSize,
              hint: getTranslated(context, "card_expiry_date"),
              controller: TextEditingController(),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              icon: "",
              validate: (_) {},
              onEditingComplete: () {}),
          CustomTextField(
              deviceSize: deviceSize,
              hint: getTranslated(context, "card_cvv"),
              controller: TextEditingController(),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              icon: "",
              validate: (_) {},
              onEditingComplete: () {}),
          const SizedBox(
            height: 30.0,
          ),
          MainButton(
              text: getTranslated(context, "subscribe"),
              width: deviceSize.width * 0.9,
              onPressed: () {}),
          const SizedBox(
            height: 30.0,
          )
        ],
      ),
    );
  }
}

class StoreSubscriptionCard extends StatelessWidget {
  const StoreSubscriptionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: 90,
      margin: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.05),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: AppColors.secondary,
        border: Border.all(color: AppColors.primary),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              getTranslated(context, "store_subscription"),
              style: const TextStyle(
                  height: 1.6,
                  color: AppColors.black,
                  fontFamily: AppFonts.cairoFontRegular,
                  fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Text(
                getTranslated(context, "subscription_duration"),
                style: const TextStyle(
                    height: 1.6,
                    color: AppColors.black,
                    fontFamily: AppFonts.cairoFontLight,
                    fontSize: 15),
              ),
              const Spacer(),
              Text(
                getTranslated(context, "subscription_cost"),
                style: const TextStyle(
                    height: 1.6,
                    color: AppColors.black,
                    fontFamily: AppFonts.cairoFontLight,
                    fontSize: 15),
              ),
              const SizedBox(
                width: 15.0,
              )
            ],
          )
        ],
      ),
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  final bool isSelected;
  final String image;

  const PaymentMethodCard(
      {Key? key, this.isSelected = false, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    double width = (deviceSize.width * 0.9 * 0.25) - 10;
    return Container(
      width: width,
      height: width * 0.65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: AppColors.white,
        border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.grey208),
      ),
      child: Image.asset(
        image,
      ),
    );
  }
}
