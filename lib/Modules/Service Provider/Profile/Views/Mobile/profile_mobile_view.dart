import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_assets.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Modules/Authentication/authentication_view_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Order/Views/sp_order_list_view.dart';
import 'package:meem_app/Modules/Service%20Provider/Profile/Views/customer_reviews_view.dart';
import 'package:meem_app/Modules/Service%20Provider/Profile/Views/edit_profile_view.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Views/my_products_view.dart';
import 'package:meem_app/Modules/Service%20Provider/Profile/Views/payment_options_view.dart';
import 'package:meem_app/Modules/Service%20Provider/Profile/Views/shipping_options_view.dart';
import 'package:meem_app/Modules/Service%20Provider/Profile/Views/subscription_view.dart';
import 'package:provider/provider.dart';

class SpProfileMobileView extends StatefulWidget {
  const SpProfileMobileView({Key? key}) : super(key: key);

  @override
  State<SpProfileMobileView> createState() => _SpProfileMobileViewState();
}

class _SpProfileMobileViewState extends State<SpProfileMobileView> {
  late AuthenticationViewModel authViewModel;

  @override
  void initState() {
    authViewModel =
        Provider.of<AuthenticationViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authViewModel = Provider.of<AuthenticationViewModel>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getTranslated(context, "welcome"),
                          style: const TextStyle(
                              fontFamily: AppFonts.cairoFontSemiBold,
                              fontSize: 22.0),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          getTranslated(
                              context, "you_can_mentor_and_edit_your_data"),
                          style: const TextStyle(
                              fontFamily: AppFonts.cairoFontRegular,
                              fontSize: 17.0),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 50.0,
                    width: 50.0,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.secondary.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12.5)),
                    child: const ImageIcon(
                      AssetImage(
                        AppAssets.profileFilled,
                      ),
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ProfileButton(
                img: AppAssets.profileFilled,
                text: getTranslated(context, "profile"),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditSpProfileView.routeName);
                },
              ),
              ProfileButton(
                img: AppAssets.bagFilled,
                text: getTranslated(context, "orders_management"),
                onPressed: () {
                  Navigator.of(context).pushNamed(SpOrderListView.routeName);
                },
              ),
              ProfileButton(
                img: AppAssets.categoryIcon,
                text: getTranslated(context, "my_products"),
                onPressed: () {
                  Navigator.of(context).pushNamed(SpMyProductsView.routeName);
                },
              ),
              ProfileButton(
                img: AppAssets.emptyWalletAddFilled,
                text: getTranslated(context, "payment_methods"),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(SpPaymentOptionsView.routeName);
                },
              ),
              ProfileButton(
                img: AppAssets.truckFilled,
                text: getTranslated(context, "shipping_methods"),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(SpShippingOptionsView.routeName);
                },
              ),
              // ProfileButton(
              //   img: AppAssets.starFilled,
              //   text: getTranslated(context, "reviews"),
              //   onPressed: () {
              //     Navigator.of(context)
              //         .pushNamed(SpCustomerReviewsView.routeName);
              //   },
              // ),
              // Row(
              //   children: [
              //     ProfileButton(
              //       img: AppAssets.messageFilled,
              //       text: getTranslated(context, "user_chats"),
              //       onPressed: () {},
              //     ),
              //     const Spacer(),
              //     Container(
              //       margin: const EdgeInsets.symmetric(horizontal: 15.0),
              //       width: 36.0,
              //       height: 36.0,
              //       decoration: const BoxDecoration(
              //         color: AppColors.green2,
              //         shape: BoxShape.circle,
              //       ),
              //       child: const Center(
              //         child: Text(
              //           '1',
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 16.0,
              //             fontFamily: AppFonts.cairoFontRegular,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Row(
                children: [
                  ProfileButton(
                    img: AppAssets.cardFilled,
                    text: getTranslated(context, "subscribe"),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(SpSubscriptionView.routeName);
                    },
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    getTranslated(context, "please_subscribe_in_meem"),
                    style: const TextStyle(
                        fontFamily: AppFonts.cairoFontSemiBold,
                        fontSize: 18,
                        height: 1.2,
                        color: AppColors.grey135),
                  )
                ],
              ),
              Row(
                children: [
                  ProfileButton(
                    img: AppAssets.globalIcon,
                    text: getTranslated(context, "language"),
                    onPressed: () {},
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      getTranslated(context, "arabic"),
                      style: const TextStyle(
                          fontFamily: AppFonts.cairoFontRegular,
                          fontSize: 18,
                          height: 1.2,
                          color: AppColors.primary),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  authViewModel.logout(context);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 22),
                      child: const ImageIcon(
                        AssetImage(
                          AppAssets.logoutIcon,
                        ),
                        color: AppColors.favRed,
                        size: 30,
                      ),
                    ),
                    Text(
                      getTranslated(context, "logout"),
                      style: const TextStyle(
                          fontFamily: AppFonts.cairoFontRegular,
                          fontSize: 18,
                          height: 1.2,
                          color: AppColors.favRed),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.img,
  }) : super(key: key);

  final Function onPressed;
  final String text;
  final String img;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12.5)),
            child: ImageIcon(
              AssetImage(
                img,
              ),
              color: AppColors.primary,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
                fontFamily: AppFonts.cairoFontSemiBold,
                fontSize: 18,
                height: 1.2,
                color: AppColors.black),
          )
        ],
      ),
    );
  }
}
