import 'package:flutter/material.dart';
import 'package:meem_app/CommonWidget/title_appbar.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';

class SpCustomerReviewsMobileView extends StatefulWidget {
  const SpCustomerReviewsMobileView({Key? key}) : super(key: key);

  @override
  State<SpCustomerReviewsMobileView> createState() =>
      _SpCustomerReviewsMobileViewState();
}

class _SpCustomerReviewsMobileViewState
    extends State<SpCustomerReviewsMobileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: TitleAppBar(
          title: getTranslated(context, "customer_reviews"),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              for (int i = 0; i < 4; i++)
                ReviewWidget(
                  username: " عبد العزيز محمد",
                  text: "المنتج مرة رائع و وصل في الوقت المحدد شكرا",
                  duration: getTranslated(context, "from"),
                  isLast: i == 4 - 1,
                ),
            ]),
      ),
    );
  }
}

class ReviewWidget extends StatelessWidget {
  final String username;
  final String text;
  final String duration;
  final bool isLast;
  const ReviewWidget(
      {Key? key,
      required this.username,
      required this.text,
      required this.duration,
      required this.isLast})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: deviceSize.width * 0.05, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                username,
                style: const TextStyle(
                    height: 1.6,
                    color: AppColors.grey162,
                    fontFamily: AppFonts.cairoFontRegular,
                    fontSize: 17),
              ),
              Text(
                username,
                style: const TextStyle(
                    height: 1.6,
                    color: AppColors.black,
                    fontFamily: AppFonts.cairoFontRegular,
                    fontSize: 17),
              ),
            ],
          ),
          Column(
            children: [
              SelectableText(
                text,
                style: const TextStyle(
                    height: 1.6,
                    color: AppColors.black,
                    fontFamily: AppFonts.cairoFontMedium,
                    fontSize: 17),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            duration,
            style: const TextStyle(
                height: 1.6,
                color: AppColors.primary,
                fontFamily: AppFonts.cairoFontRegular,
                fontSize: 17),
          ),
          const SizedBox(
            height: 10.0,
          ),
          if (!isLast)
            const Divider(
              color: AppColors.grey217,
            )
        ],
      ),
    );
  }
}
