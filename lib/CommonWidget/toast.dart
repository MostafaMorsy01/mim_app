import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/meem_app.dart';

toastAppErr(String msg,{BuildContext? contest}) {

  return showFlash(
    context: contest == null ? MeemApp.contexts! : contest,
    duration: Duration(seconds: 2),
    builder: (context, controller) {
      return Flash(
        useSafeArea: true,
        brightness: Brightness.light,
        backgroundColor: AppColors.declinedRed,
        controller: controller,
        behavior: FlashBehavior.floating,
        position: FlashPosition.top,
        boxShadows: kElevationToShadow[4],
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        child: FlashBar(
          content: Text(msg, style: TextStyle(color: Colors.white),),
        ),
      );
    },
  );


}

toastAppSuccess(String msg,{BuildContext? contest}) {
  return showFlash(
    context: contest == null ? MeemApp.contexts! : contest,
    duration: Duration(seconds: 2),
    builder: (context, controller) {
      return Flash(
        useSafeArea: true,
        brightness: Brightness.light,
        backgroundColor: AppColors.primary,
        controller: controller,
        behavior: FlashBehavior.floating,
        position: FlashPosition.top,
        boxShadows: kElevationToShadow[4],
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        child: FlashBar(
          content: Text(msg, style: TextStyle(color: Colors.white),),
        ),
      );
    },
  );
}