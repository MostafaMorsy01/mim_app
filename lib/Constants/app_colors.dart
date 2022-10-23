import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color.fromRGBO(10, 161, 221, 1);
  static const Color secondary = Color.fromRGBO(170, 230, 254, 0.3);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color white80 = Color.fromRGBO(255, 255, 255, 0.8);
  static const Color black = Color.fromRGBO(0, 0, 0, 1);
  static const Color grey135 = Color.fromRGBO(135, 135, 135, 1);
  static const Color searchBarHint = Color.fromRGBO(60, 60, 67, 0.6);
  static const Color searchBarFill = Color.fromRGBO(118, 118, 128, 0.12);
  static const Color searchBarClearRed = Color.fromRGBO(235, 87, 87, 1);
  static const Color grey159 = Color.fromRGBO(159, 159, 159, 1);
  static const Color grey189 = Color.fromRGBO(189, 189, 189, 1);
  static const Color grey162 = Color.fromRGBO(162, 162, 162, 1);
  static const Color grey208 = Color.fromRGBO(208, 213, 221, 1);
  static const Color grey217 = Color.fromRGBO(217, 217, 217, 1);
  static const Color offWhite = Color.fromRGBO(245, 247, 248, 1);

  static const Color textFieldFill = Color.fromRGBO(248, 250, 253, 1);
  static const Color textFieldIcon = Color.fromRGBO(41, 45, 50, 1);
  static const Color background = Color.fromRGBO(229, 229, 229, 1);
  static const Color acceptedGreen = Color.fromRGBO(25, 129, 85, 1);
  static const Color pendingOrange = Color.fromRGBO(160, 94, 3, 1);
  static const Color declinedRed = Color.fromRGBO(211, 24, 12, 1);
  static const Color favRed = Color.fromRGBO(235, 87, 87, 1);

  static const Color blue1 = Color.fromRGBO(47, 128, 237, 1);
  static const Color green2 = Color.fromRGBO(39, 174, 96, 1);
  static const Color green3 = Color.fromRGBO(111, 207, 151, 1);

  static Color shimmerBaseColor = Colors.grey[300]!;
  static Color shimmerHighlightColor = Colors.grey[100]!;
  static const Color fbBlue = Color.fromRGBO(24, 119, 242, 1);
  static const Color googleRed = Color.fromRGBO(234, 67, 53, 1);
}

final Map<int, Color> primaryMap = {
  50: AppColors.primary,
  100: AppColors.primary,
  200: AppColors.primary,
  300: AppColors.primary,
  400: AppColors.primary,
  500: AppColors.primary,
  600: AppColors.primary,
  700: AppColors.primary,
  800: AppColors.primary,
  900: AppColors.primary,
};

final MaterialColor mainMaterialColor =
    MaterialColor(AppColors.primary.value, primaryMap);
