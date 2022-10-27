import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';

class TitleAppBar extends StatelessWidget {
  const TitleAppBar(
      {Key? key,
      required this.title,
      this.buttonTitle,
      this.buttonTitleColor,
      this.onPrssed})
      : super(key: key);
  final String title;
  final String? buttonTitle;
  final Color? buttonTitleColor;
  final Function? onPrssed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      color: AppColors.white,
      child: SafeArea(
        child: Row(
          children: [
            SizedBox(
              width: 85,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.primary,
                  size: 32,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            const Spacer(),
            SelectableText(
              title,
              style: const TextStyle(
                  fontFamily: AppFonts.cairoFontRegular, fontSize: 27),
            ),
            const Spacer(),
            SizedBox(
              width: 85,
              child: buttonTitle != null
                  ? TextButton(
                      onPressed: () {
                        onPrssed!();
                      },
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          buttonTitle!,
                          style: TextStyle(
                              fontFamily: AppFonts.cairoFontBold,
                              fontSize: 17,
                              // ignore: prefer_if_null_operators
                              color: buttonTitleColor != null
                                  ? buttonTitleColor
                                  : AppColors.primary),
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class TitleAppBar1 extends StatelessWidget {
  const TitleAppBar1(
      {Key? key,
        required this.title,
        this.buttonTitle,
        this.buttonTitleColor,
        this.onPrssed})
      : super(key: key);
  final String title;
  final String? buttonTitle;
  final Color? buttonTitleColor;
  final Function? onPrssed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      color: AppColors.white,
      child: SafeArea(
        child: Row(
          children: [
            SizedBox(
              width: 85,

            ),
            const Spacer(),
            SelectableText(
              title,
              style: const TextStyle(
                  fontFamily: AppFonts.cairoFontRegular, fontSize: 27),
            ),
            const Spacer(),
            SizedBox(
              width: 85,
              child: buttonTitle != null
                  ? TextButton(
                onPressed: () {
                  onPrssed!();
                },
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    buttonTitle!,
                    style: TextStyle(
                        fontFamily: AppFonts.cairoFontBold,
                        fontSize: 17,
                        // ignore: prefer_if_null_operators
                        color: buttonTitleColor != null
                            ? buttonTitleColor
                            : AppColors.primary),
                  ),
                ),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}


class TitleAppBarWithNavigation extends StatelessWidget {
  const TitleAppBarWithNavigation(
      {Key? key,
        required this.title,
        this.buttonTitle,
        this.onNav,
        this.buttonTitleColor,
        this.onPrssed})
      : super(key: key);
  final String title;
  final String? buttonTitle;
  final Color? buttonTitleColor;
  final Function? onPrssed;
  final Function? onNav;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      color: AppColors.white,
      child: SafeArea(
        child: Row(
          children: [
            SizedBox(
              width: 85,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.primary,
                  size: 32,
                ),
                onPressed: () {
                  onNav!();
                },
              ),
            ),
            const Spacer(),
            SelectableText(
              title,
              style: const TextStyle(
                  fontFamily: AppFonts.cairoFontRegular, fontSize: 27),
            ),
            const Spacer(),
            SizedBox(
              width: 85,
              child: buttonTitle != null
                  ? TextButton(
                onPressed: () {
                  onPrssed!();
                },
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    buttonTitle!,
                    style: TextStyle(
                        fontFamily: AppFonts.cairoFontBold,
                        fontSize: 17,
                        // ignore: prefer_if_null_operators
                        color: buttonTitleColor != null
                            ? buttonTitleColor
                            : AppColors.primary),
                  ),
                ),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}