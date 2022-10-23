import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpTextField extends StatefulWidget {
  final TextEditingController controller;
  final Size deviceSize;
  final GlobalKey<FormState> formKey;
  const OtpTextField(
      {Key? key,
      required this.controller,
      required this.deviceSize,
      required this.formKey})
      : super(key: key);

  @override
  State<OtpTextField> createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: widget.deviceSize.width * 0.9,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: PinCodeTextField(
                  mainAxisAlignment: MainAxisAlignment.center,
                  appContext: context,
                  pastedTextStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: AppFonts.cairoFontMedium,
                  ),
                  errorTextDirection: TextDirection.rtl,
                  length: 4,
                  obscureText: true,
                  obscuringCharacter: '*',
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.length < 3) {
                      return "I'm from validator";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 30,
                      fieldWidth: 60,
                      activeFillColor: AppColors.white,
                      activeColor: AppColors.white,
                      disabledColor: AppColors.white,
                      selectedColor: AppColors.white,
                      selectedFillColor: AppColors.white,
                      errorBorderColor: AppColors.white,
                      inactiveColor: AppColors.white,
                      inactiveFillColor: AppColors.white),
                  cursorColor: AppColors.black,
                  animationDuration: const Duration(milliseconds: 300),
                  errorAnimationController: errorController,
                  controller: widget.controller,
                  keyboardType: TextInputType.number,
                  onCompleted: (otp) {
                    widget.controller.text = otp;
                  },
                  onChanged: (value) {
                    debugPrint(value);
                    setState(() {
                      currentText = value;
                    });
                    // widget.controller.text = value;
                  },
                  beforeTextPaste: (text) {
                    debugPrint("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
              )),
        ),
        SizedBox(
          width: widget.deviceSize.width * 0.8,
          child: const Divider(
            color: AppColors.blue1,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
