import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

import '../Constants/app_colors.dart';
import '../Localization/app_localization.dart';

class FlashWidgets {
  static void showNetworkErrorBar({
    required BuildContext context,
    FlashPosition position = FlashPosition.top,
    FlashBehavior behavior = FlashBehavior.fixed,
  }) {
    showFlash(
      context: context,
      builder: (context, controller) {
        return Flash(
          controller: controller,
          behavior: behavior,
          position: position,
          boxShadows: kElevationToShadow[4],
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          child: FlashBar(
            indicatorColor: Colors.red,
            icon: const Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
            content: Text(
                getTranslated(context, "you_are_not_connected_to_any_network")),
            primaryAction: TextButton(
              onPressed: () {
                controller.dismiss();
              },
              child: Text(
                getTranslated(context, "dismiss"),
              ),
            ),
          ),
        );
      },
    );
  }

  static void showWarningBar({
    required BuildContext context,
    required String message,
    FlashPosition position = FlashPosition.bottom,
    FlashBehavior behavior = FlashBehavior.floating,
  }) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 3),
      builder: (context, controller) {
        return Flash(
          margin: const EdgeInsets.only(bottom: 15),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9),
          borderRadius: BorderRadius.circular(6),
          controller: controller,
          behavior: behavior,
          position: position,
          backgroundColor: AppColors.pendingOrange,
          boxShadows: kElevationToShadow[4],
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          child: FlashBar(
            indicatorColor: AppColors.pendingOrange,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            content: Text(
              message,
              style: const TextStyle(
                  color: AppColors.white,
                  //fontFamily: AppFonts.montserratFontSemiBold,
                  fontSize: 16),
            ),
          ),
        );
      },
    );
  }

  static void showSuccessBar({
    required BuildContext context,
    required String message,
    FlashPosition position = FlashPosition.bottom,
    FlashBehavior behavior = FlashBehavior.floating,
  }) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 3),
      builder: (context, controller) {
        return Flash(
          margin: const EdgeInsets.only(bottom: 15),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9),
          borderRadius: BorderRadius.circular(6),
          controller: controller,
          behavior: behavior,
          position: position,
          backgroundColor: AppColors.acceptedGreen,
          boxShadows: kElevationToShadow[4],
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          child: FlashBar(
            indicatorColor: AppColors.acceptedGreen,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            content: Text(
              message,
              style: const TextStyle(
                  color: AppColors.white,
                  //fontFamily: AppFonts.montserratFontSemiBold,
                  fontSize: 16),
            ),
          ),
        );
      },
    );
  }

  static void showErrorBar({
    required BuildContext context,
    required String message,
    FlashPosition position = FlashPosition.bottom,
    FlashBehavior behavior = FlashBehavior.floating,
  }) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 3),
      builder: (context, controller) {
        return Flash(
          margin: const EdgeInsets.only(bottom: 15),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9),
          borderRadius: BorderRadius.circular(6),
          controller: controller,
          behavior: behavior,
          position: position,
          backgroundColor: AppColors.declinedRed,
          boxShadows: kElevationToShadow[4],
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          child: FlashBar(
            indicatorColor: AppColors.declinedRed,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            content: Text(
              message,
              style: const TextStyle(
                  color: AppColors.white,
                  //fontFamily: AppFonts.montserratFontSemiBold,
                  fontSize: 16),
            ),
          ),
        );
      },
    );
  }
}
