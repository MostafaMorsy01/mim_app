import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';

class MainButton extends StatelessWidget {
  final String text;
  final double width;
  final Function onPressed;

  const MainButton(
      {Key? key,
      required this.text,
      required this.width,
      required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: 60,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: AppColors.primary,
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                height: 1.6,
                color: AppColors.white,
                fontFamily: AppFonts.cairoFontBold,
                fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class MainButton1 extends StatelessWidget {
  final String text;
  final double width;
  final Function onPressed;

  const MainButton1(
      {Key? key,
        required this.text,
        required this.width,
        required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: 60,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: AppColors.secondary,
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                height: 1.6,
                color: AppColors.primary,
                fontFamily: AppFonts.cairoFontBold,
                fontSize: 18),
          ),
        ),
      ),
    );
  }
}