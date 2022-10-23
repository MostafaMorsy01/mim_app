import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_assets.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Modules/Authentication/authentication_view_model.dart';
import 'package:provider/provider.dart';

class ProfileMobileView extends StatefulWidget {
  const ProfileMobileView({Key? key}) : super(key: key);

  @override
  State<ProfileMobileView> createState() => _ProfileMobileViewState();
}

class _ProfileMobileViewState extends State<ProfileMobileView> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            ProfileButton(
              img: AppAssets.profileFilled,
              text: getTranslated(context, "profile"),
              onPressed: () {},
            ),
            ProfileButton(
              img: AppAssets.bagFilled,
              text: getTranslated(context, "my_orders"),
              onPressed: () {},
            ),
            ProfileButton(
              img: AppAssets.locationFilled,
              text: getTranslated(context, "my_addresses"),
              onPressed: () {},
            ),
            ProfileButton(
              img: AppAssets.favBlueFilled,
              text: getTranslated(context, "favorites"),
              onPressed: () {},
            ),
            ProfileButton(
              img: AppAssets.cardFilled,
              text: getTranslated(context, "payment_methods"),
              onPressed: () {},
            ),
            ProfileButton(
              img: AppAssets.messageFilled,
              text: getTranslated(context, "store_chats"),
              onPressed: () {},
            ),
            ProfileButton(
              img: AppAssets.messagesFilled,
              text: getTranslated(context, "complaints"),
              onPressed: () {},
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
              onTap: () async {
                await authViewModel.logout(context);
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
          ],
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
