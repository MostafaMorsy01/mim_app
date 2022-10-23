import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.deviceSize,
    required this.hint,
    required this.controller,
    required this.textInputAction,
    required this.keyboardType,
    required this.validate,
    required this.onEditingComplete,
    this.width = 0.9,
    required this.icon,
    this.suffixIcon = "",
    this.obsecure = false,
    this.isTablet = false,
    this.onPressed,
    this.readOnly = false,
  }) : super(key: key);

  final Size deviceSize;
  final String hint;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final String? Function(String?)? validate;
  final Function()? onEditingComplete;
  final double width;
  final String icon;
  final String suffixIcon;
  final bool obsecure;
  final bool isTablet;
  final Function? onPressed;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: deviceSize.width * width,
          margin: const EdgeInsets.only(bottom: 15.0),
          padding: const EdgeInsets.only(bottom: 10.0),
          child: TextFormField(
            controller: controller,
            onTap: () {
              if (onPressed != null) onPressed!();
            },
            readOnly: readOnly,
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            maxLines: 1,
            obscureText: obsecure,
            validator: validate,
            onEditingComplete: onEditingComplete,
            style: TextStyle(
              color: Colors.black,
              fontFamily: AppFonts.cairoFontRegular,
              fontSize: deviceSize.height > 900
                  ? 28
                  : (deviceSize.height > 450 ? 18 : 18),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                  color: AppColors.black,
                  fontFamily: AppFonts.cairoFontRegular,
                  fontSize: 17.0),
              errorStyle: TextStyle(
                fontSize: isTablet ? 20 : 14.0,
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primary,
                ),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primary,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primary,
                ),
              ),
              prefixIcon: icon != ""
                  ? ImageIcon(
                      AssetImage(icon),
                      color: AppColors.textFieldIcon,
                      size: 10,
                    )
                  : null,
              suffixIcon: suffixIcon != ""
                  ? ImageIcon(
                      AssetImage(suffixIcon),
                      color: AppColors.primary,
                      size: 10,
                    )
                  : null,
            ),
            cursorColor: Colors.black,
          ),
        ),
      ],
    );
  }
}
