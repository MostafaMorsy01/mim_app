import 'package:flutter/material.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:email_validator/email_validator.dart';

class AppValidations {
  static String? validateEmail(String email, BuildContext context) {
    if (email.isEmpty) {
      return getTranslated(context, "enter_an_mail_address");
    } else if (!EmailValidator.validate(email)) {
      return getTranslated(context, "invalid_email_address");
    }
    return null;
  }

  static String? validateNotEmptyText(
      String text, BuildContext context, String message) {
    if (text.isEmpty) {
      return getTranslated(context, message);
    } else {
      return null;
    }
  }

  static String? validatePassword(String password, BuildContext context) {
    RegExp passwordRegExp = RegExp(r"^([^\s]){8,14}$");
    if (password.isEmpty) {
      return getTranslated(context, "enter_a_password");
    } else if (!passwordRegExp.hasMatch(password)) {
      return getTranslated(context, "use_8_to_14_character_for_your_password");
    }
    return null;
  }

  static String? validatePhoneNumber(String phoneNumber, BuildContext context) {
    if (phoneNumber.isEmpty) {
      return getTranslated(context, "enter_a_phone_number");
    } else if (phoneNumber.length != 9) {
      return getTranslated(context, "enter_a_valid_phone_number");
    }
    return null;
  }

  static String? validateConfirmPassword(
      String password, String confirmPassword, BuildContext context) {
    RegExp passwordRegExp = RegExp(r"^([^\s]){8,14}$");
    if (confirmPassword.isEmpty) {
      return getTranslated(context, "enter_a_password");
    } else if (!passwordRegExp.hasMatch(confirmPassword)) {
      return getTranslated(context, "use_8_to_14_character_for_your_password");
    } else if (password != confirmPassword) {
      return getTranslated(context, "those_passwords_didn’t_match");
    }
    return null;
  }
}
