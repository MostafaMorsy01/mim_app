import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_assets.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';

class NoInternetMobileView extends StatefulWidget {
  const NoInternetMobileView({Key? key}) : super(key: key);

  @override
  State<NoInternetMobileView> createState() => _NoInternetMobileViewState();
}

class _NoInternetMobileViewState extends State<NoInternetMobileView> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(),
          Image.asset(
            AppAssets.noInternet,
            width: deviceSize.width * 0.5,
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: SelectableText(
              getTranslated(context, "no_internet_connection"),
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontFamily: AppFonts.cairoFontRegular,
                  fontSize: 27,
                  color: AppColors.primary),
            ),
          ),
          SizedBox(
            width: deviceSize.width * 0.55,
            child: SelectableText(
              getTranslated(context, "no_internet_message"),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: AppFonts.cairoFontRegular,
                  fontSize: 18,
                  height: 1.2,
                  color: AppColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
