import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:meem_app/Localization/app_localization.dart';

import '../Constants/app_colors.dart';
import '../Constants/app_constants.dart';

showVersionAlertDialog(BuildContext context, bool isObligatory,
    Function onUpdate, Function onCancel) {
  Widget cancelButton = TextButton(
    child: Text(
      getTranslated(context, "cancel"),
      style: const TextStyle(color: AppColors.declinedRed),
    ),
    onPressed: () {
      onCancel();
      AppConstants.navigatorKey?.currentState?.pop(context);
    },
  );
  Widget updateButton = TextButton(
    child: Text(
      getTranslated(context, "update"),
      style: const TextStyle(color: AppColors.primary),
    ),
    onPressed: () async {
      await onUpdate();
    },
  );

  // set up the AlertDialog
  var alert = Platform.isAndroid
      ? AlertDialog(
          title: Text(getTranslated(context, "update")),
          content: Text(getTranslated(context, "there_is_an_update_available")),
          actions: isObligatory
              ? [
                  updateButton,
                ]
              : [
                  cancelButton,
                  updateButton,
                ],
        )
      : CupertinoAlertDialog(
          title: Text(getTranslated(context, "update")),
          content: Text(getTranslated(context, "there_is_an_update_available")),
          actions: isObligatory
              ? [
                  updateButton,
                ]
              : [
                  cancelButton,
                  updateButton,
                ],
        );

  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
