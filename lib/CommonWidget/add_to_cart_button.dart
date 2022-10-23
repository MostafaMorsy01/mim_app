import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';

class AddToCartButton extends StatelessWidget {
  final double? width;
  final Function onPressed;

  const AddToCartButton({Key? key, this.width, required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onPressed();
      },
      child: Container(
        height: 60,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primary,
        ),
        child: Center(
          child: Text(
            getTranslated(context, "add_to_cart"),
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
