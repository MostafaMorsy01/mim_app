import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meem_app/CommonWidget/custom_text_field_widget.dart';
import 'package:meem_app/CommonWidget/main_button.dart';
import 'package:meem_app/CommonWidget/secondary_button.dart';
import 'package:meem_app/Constants/app_assets.dart';
import 'package:meem_app/Constants/app_enums.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Modules/Authentication/Widgets/selectable_circle_widget.dart';
import 'package:meem_app/Modules/Authentication/authentication_navigations.dart';
import 'package:meem_app/Modules/Authentication/authentication_view_model.dart';
import 'package:meem_app/Services/text_field_validations.dart';
import 'package:provider/provider.dart';

import '/../../../../Constants/app_colors.dart';

class LoginMobileView extends StatefulWidget {
  const LoginMobileView({Key? key}) : super(key: key);

  @override
  _LoginMobileViewState createState() => _LoginMobileViewState();
}

class _LoginMobileViewState extends State<LoginMobileView> {
  late AuthenticationViewModel authViewModel;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    authViewModel =
        Provider.of<AuthenticationViewModel>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final node = FocusScope.of(context);
    authViewModel = Provider.of<AuthenticationViewModel>(context, listen: true);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(),
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  AppAssets.logo,
                  width: 125,
                ),
                const SizedBox(
                  height: 20,
                ),
                SelectableText(
                  getTranslated(context, "welcome"),
                  style: const TextStyle(
                      fontFamily: AppFonts.cairoFontSemiBold, fontSize: 22.0),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                SelectableText(
                  authViewModel.isUserSelected
                      ? getTranslated(context, "login_user")
                      : getTranslated(context, "login_sp"),
                  style: const TextStyle(
                      fontFamily: AppFonts.cairoFontRegular, fontSize: 17.0),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: deviceSize.width * 0.9,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SelectableText(
                      getTranslated(context, "account_type"),
                      style: const TextStyle(
                          fontFamily: AppFonts.cairoFontRegular,
                          fontSize: 17.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SelectableCircleWidget(
                  deviceSize: deviceSize,
                  isSelected: authViewModel.isUserSelected,
                  title: getTranslated(context, "user"),
                  onPressed: () {
                    setState(() {
                      authViewModel.isUserSelected = true;
                    });
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SelectableCircleWidget(
                  deviceSize: deviceSize,
                  isSelected: !authViewModel.isUserSelected,
                  title: getTranslated(context, "service_provider"),
                  onPressed: () {
                    setState(() {
                      authViewModel.isUserSelected = false;
                    });
                  },
                ),
                const SizedBox(
                  height: 30.0,
                ),
                CustomTextField(
                    deviceSize: deviceSize,
                    hint: getTranslated(context, "email"),
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    icon: AppAssets.mailIcon,
                    validate: (_) {
                      return AppValidations.validateEmail(
                          emailController.text, context);
                    },
                    onEditingComplete: () {
                      node.nextFocus();
                    }),
                CustomTextField(
                    deviceSize: deviceSize,
                    hint: getTranslated(context, "password"),
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    obsecure: true,
                    validate: (_) {
                      return AppValidations.validatePassword(
                          passwordController.text, context);
                    },
                    icon: AppAssets.lockIcon,
                    onEditingComplete: () {
                      node.unfocus();
                    }),
                TextButton(
                  onPressed: () async {
                    AuthenticationNavigations.forgetPasswordNavigation(context,
                        authViewModel.isUserSelected ? "user" : "store");
                  },
                  child: SizedBox(
                    width: deviceSize.width * 0.9,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        getTranslated(context, "forgot_password"),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontFamily: AppFonts.cairoFontLight,
                          fontSize: 17.0,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                authViewModel.status == Status.loading
                    ? const Center(child: CircularProgressIndicator())
                    : MainButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            bool result = await authViewModel.login(
                                emailController.text,
                                passwordController.text,
                                Platform.isAndroid ? "Android" : "IOS",
                                authViewModel.isUserSelected ? "user" : "store",
                                context);
                            if (result) {
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                            }
                          }
                        },
                        text: getTranslated(context, "login"),
                        width: deviceSize.width * 0.9),
                const SizedBox(
                  height: 30.0,
                ),
                SelectableText(
                  getTranslated(context, "login_with"),
                  style: const TextStyle(
                      fontFamily: AppFonts.cairoFontRegular, fontSize: 17.0),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColors.googleRed,
                              border: Border.all(color: AppColors.googleRed),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Image.asset(AppAssets.googleIcon)),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    InkWell(
                      child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColors.fbBlue,
                              border: Border.all(color: AppColors.fbBlue),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Image.asset(AppAssets.fbIcon)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35.0,
                ),
                SecondaryButton(
                    text: getTranslated(context, "create_sp_account_2"),
                    width: deviceSize.width * 0.9,
                    onPressed: () {
                      authViewModel.isUserSelected = false;
                      AuthenticationNavigations.signupNavigation(context);
                    }),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: deviceSize.width * 0.9,
                  child: TextButton(
                    onPressed: () {
                      AuthenticationNavigations.signupNavigation(context);
                    },
                    child: Text(
                      getTranslated(context, "dont_have_account"),
                      style: const TextStyle(
                          height: 1.6,
                          color: AppColors.primary,
                          fontFamily: AppFonts.cairoFontMedium,
                          fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
