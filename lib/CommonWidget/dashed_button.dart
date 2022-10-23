import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:dotted_border/dotted_border.dart';

class DashedButton extends StatelessWidget {
  final String text;
  final double width;
  final Function onPressed;

  const DashedButton(
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
          color: AppColors.white,
        ),
        child: DottedBorder(
          borderType: BorderType.RRect,
          strokeWidth: 1.5,
          dashPattern: const [10, 5],
          color: AppColors.primary,
          radius: const Radius.circular(13.0),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  height: 1.6,
                  color: AppColors.blue1,
                  fontFamily: AppFonts.cairoFontBold,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
