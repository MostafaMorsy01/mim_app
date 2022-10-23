import 'package:flutter/material.dart';
import 'package:meem_app/CommonWidget/custom_text_field_widget.dart';
import 'package:meem_app/CommonWidget/main_button.dart';
import 'package:meem_app/Constants/app_assets.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_enums.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Modules/Authentication/authentication_navigations.dart';
import 'package:meem_app/Modules/Authentication/authentication_view_model.dart';
import 'package:meem_app/Services/text_field_validations.dart';
import 'package:provider/provider.dart';

class UserSignupWidget extends StatefulWidget {
  const UserSignupWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<UserSignupWidget> createState() => _UserSignupWidgetState();
}

class _UserSignupWidgetState extends State<UserSignupWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AuthenticationViewModel authViewModel;

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
    authViewModel = Provider.of<AuthenticationViewModel>(context, listen: true);
    final deviceSize = MediaQuery.of(context).size;
    final node = FocusScope.of(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
              deviceSize: deviceSize,
              hint: getTranslated(context, "name"),
              controller: nameController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              icon: AppAssets.profileIcon,
              validate: (_) {
                return AppValidations.validateNotEmptyText(
                    nameController.text, context, "enter_your_name");
              },
              onEditingComplete: () {
                node.nextFocus();
              }),
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
          const SizedBox(
            height: 30.0,
          ),
          authViewModel.status == Status.loading
              ? const CircularProgressIndicator(
                  color: AppColors.primary,
                )
              : MainButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool result = await authViewModel.userSignUp(
                          nameController.text,
                          emailController.text,
                          phoneNumberController.text,
                          passwordController.text,
                          context);
                      if (result) {
                        AuthenticationNavigations.phoneVerificationNavigation(
                            context, "user");
                      }
                    }
                  },
                  text: getTranslated(context, "create_account"),
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
          SizedBox(
            width: deviceSize.width * 0.9,
            child: TextButton(
              onPressed: () {
                AuthenticationNavigations.loginNavigation(context);
              },
              child: Text(
                getTranslated(context, "already_have_account"),
                style: const TextStyle(
                    height: 1.6,
                    color: AppColors.primary,
                    fontFamily: AppFonts.cairoFontLight,
                    fontSize: 20),
              ),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }
}
