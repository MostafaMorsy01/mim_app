import 'package:flutter/material.dart';
import 'package:meem_app/CommonWidget/custom_text_field_widget.dart';
import 'package:meem_app/CommonWidget/main_button.dart';
import 'package:meem_app/Constants/app_assets.dart';
import 'package:meem_app/Constants/app_enums.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Modules/Authentication/authentication_navigations.dart';
import 'package:meem_app/Modules/Authentication/authentication_view_model.dart';
import 'package:meem_app/Services/text_field_validations.dart';
import 'package:provider/provider.dart';

import '/../../../../Constants/app_colors.dart';

class ForgetPasswordMobileView extends StatefulWidget {
  final String userType;
  const ForgetPasswordMobileView({Key? key, required this.userType})
      : super(key: key);

  @override
  _ForgetPasswordMobileViewState createState() =>
      _ForgetPasswordMobileViewState();
}

class _ForgetPasswordMobileViewState extends State<ForgetPasswordMobileView> {
  TextEditingController phoneNumberController = TextEditingController();
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
        floatingActionButton: authViewModel.status == Status.loading
            ? const CircularProgressIndicator()
            : MainButton(
                width: deviceSize.width * 0.9,
                text: getTranslated(context, "send"),
                onPressed: () async {
                  AuthenticationNavigations.resetPasswordNavigation(
                      context, authViewModel.isUserSelected ? "user" : "store");
                  if (formKey.currentState!.validate()) {
                    bool result = await authViewModel.forgotPassword(
                        authViewModel.userId.toString(), context);
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
                      getTranslated(context, "forgot_password") + "؟",
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
                  CustomTextField(
                      deviceSize: deviceSize,
                      hint: getTranslated(context, "phone_number"),
                      controller: phoneNumberController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      icon: AppAssets.lockIcon,
                      validate: (_) {
                        return AppValidations.validatePhoneNumber(
                            phoneNumberController.text, context);
                      },
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
