import 'package:flutter/material.dart';

import '/../../../../Constants/app_colors.dart';

class LandingMobileView extends StatefulWidget {
  const LandingMobileView({Key? key}) : super(key: key);

  @override
  State<LandingMobileView> createState() => _LandingMobileViewState();
}

class _LandingMobileViewState extends State<LandingMobileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(),
    );
  }
}
