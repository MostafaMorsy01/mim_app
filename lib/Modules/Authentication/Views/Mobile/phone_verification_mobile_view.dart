import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meem_app/CommonWidget/main_button.dart';
import 'package:meem_app/Constants/app_enums.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Modules/Authentication/Widgets/otp_text_field.dart';
import 'package:meem_app/Modules/Authentication/authentication_view_model.dart';
import 'package:provider/provider.dart';

import '/../../../../Constants/app_colors.dart';

class PhoneVerificationMobileView extends StatefulWidget {
  final String userType;
  const PhoneVerificationMobileView({Key? key, required this.userType})
      : super(key: key);

  @override
  _PhoneVerificationMobileViewState createState() =>
      _PhoneVerificationMobileViewState();
}

class _PhoneVerificationMobileViewState
    extends State<PhoneVerificationMobileView> {
  TextEditingController otpController = TextEditingController();
  bool isUserSeleted = true;
  late AuthenticationViewModel authViewModel;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    authViewModel =
        Provider.of<AuthenticationViewModel>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    authViewModel = Provider.of<AuthenticationViewModel>(context, listen: true);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0.0,
          foregroundColor: AppColors.primary,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: authViewModel.status == Status.loading
            ? const CircularProgressIndicator()
            : MainButton(
                width: deviceSize.width * 0.9,
                text: getTranslated(
                  context,
                  "verify",
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    bool result = await authViewModel.verifyCode(
                        authViewModel.userId.toString(),
                        Platform.isAndroid ? "Android" : "IOS",
                        otpController.text,
                        widget.userType,
                        context);
                    if (result) {}
                  }
                }),
        backgroundColor: AppColors.white,
        body: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: deviceSize.width * 0.9,
                    child: SelectableText(
                      getTranslated(context, "verify_account"),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: AppFonts.cairoFontMedium, fontSize: 22.0),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: deviceSize.width * 0.9,
                    child: SelectableText(
                      getTranslated(
                          context, "please_enter_otp_code_sent_to_your_mail"),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: AppFonts.cairoFontRegular,
                          fontSize: 17.0),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  OtpTextField(
                    deviceSize: deviceSize,
                    controller: otpController,
                    formKey: formKey,
                  ),
                  authViewModel.secondaryStatus == Status.loading
                      ? const Center(child: CircularProgressIndicator())
                      : TextButton(
                          onPressed: () async {
                            await authViewModel.resendCode(
                                authViewModel.userId.toString(),
                                widget.userType,
                                context);
                          },
                          child: SizedBox(
                            width: deviceSize.width * 0.9,
                            child: Text(
                              getTranslated(context, "resend_code"),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.grey135,
                                fontFamily: AppFonts.cairoFontLight,
                                fontSize: 14.0,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
