import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../CommonWidget/secondary_button.dart';
import '../../../../../CommonWidget/title_appbar.dart';
import '../../../../../CommonWidget/toast.dart';
import '../../../../../Constants/app_assets.dart';
import '../../../../../Constants/app_colors.dart';
import '../../../../../Constants/app_enums.dart';
import '../../../../../Constants/app_fonts.dart';
import '../../../../../Localization/app_localization.dart';
import '../../ViewModel/subscription_view_model.dart';

class SpListSubscriptionMobileView extends StatefulWidget {
  const SpListSubscriptionMobileView({Key? key}) : super(key: key);

  @override
  State<SpListSubscriptionMobileView> createState() =>
      _SpListSubscriptionMobileViewState();
}

class _SpListSubscriptionMobileViewState
    extends State<SpListSubscriptionMobileView> {
  late SubscriptionViewModel subscriptionViewModel;

  @override
  void initState() {
    // TODO: implement initState
    subscriptionViewModel =
        Provider.of<SubscriptionViewModel>(context, listen: false);

    Future(() async {
      await subscriptionViewModel.fetchListStoreSubscription(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    subscriptionViewModel =
        Provider.of<SubscriptionViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: TitleAppBar(
          title: getTranslated(context, "all_subscription"),
        ),
        elevation: 0,
      ),
      body: subscriptionViewModel.secondaryStatus == Status.loading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...List.generate(
                      subscriptionViewModel.storeListSubscriptionCoreModel
                              ?.subscriptions?.length ??
                          0,
                      (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SubscriptionsListWidget(
                              type: subscriptionViewModel
                                      .storeListSubscriptionCoreModel
                                      ?.subscriptions?[index]
                                      .name ??
                                  "",
                              duration: (subscriptionViewModel
                                          .storeListSubscriptionCoreModel
                                          ?.subscriptions?[index]
                                          .duration ??
                                      0)
                                  .toString(),
                              price: (subscriptionViewModel
                                          .storeListSubscriptionCoreModel
                                          ?.subscriptions?[index]
                                          .price ??
                                      0)
                                  .toString(),
                              onPrssed: () async {
                                bool result =
                                    await subscriptionViewModel.Subscribe(context,
                                        subscriptionViewModel
                                                .storeListSubscriptionCoreModel
                                                ?.subscriptions
                                                ?[index].id ??
                                            0
                                        );

                                if (result) {
                                  toastAppSuccess(
                                      "Your subscription Added Successfully",
                                      contest: context);
                                } else {
                                  toastAppErr(
                                      "You Must cancel your previous subscription",
                                      contest: context);
                                }
                              },
                            ),
                          ))
                ],
              ),
            ),
    );
  }
}

class SubscriptionsListWidget extends StatefulWidget {
  final String type;
  final String duration;
  final String price;
  final Function? onPrssed;

  const SubscriptionsListWidget({
    Key? key,
    required this.type,
    required this.duration,
    required this.price,
    this.onPrssed,
  }) : super(key: key);

  @override
  State<SubscriptionsListWidget> createState() =>
      _SubscriptionsListWidgetState();
}

class _SubscriptionsListWidgetState extends State<SubscriptionsListWidget> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: 110,
      margin: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.05),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: widget.type == "gold" ? AppColors.goldSub : AppColors.offWhite,
        border: Border.all(
            color: widget.type == "gold"
                ? AppColors.goldBorder
                : AppColors.grey208),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  widget.type == "gold"
                      ? getTranslated(context, "gold_subscription")
                      : getTranslated(context, "silver_subscription"),
                  style: const TextStyle(
                      height: 1.6,
                      color: AppColors.black,
                      fontFamily: AppFonts.cairoFontRegular,
                      fontSize: 18),
                ),
              ),
              TextButton(
                onPressed: () {
                  widget.onPrssed!();
                },
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    getTranslated(context, "subscription_button"),
                    style: TextStyle(
                        fontFamily: AppFonts.cairoFontBold,
                        fontSize: 17,
                        // ignore: prefer_if_null_operators
                        color: AppColors.primary),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Text(
                getTranslated(context, "subscription_duration") +
                    " ${widget.duration} ",
                style: const TextStyle(
                    height: 1.6,
                    color: AppColors.black,
                    fontFamily: AppFonts.cairoFontLight,
                    fontSize: 15),
              ),
              const Spacer(),
              Text(
                "${widget.price} " + getTranslated(context, "cost"),
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
