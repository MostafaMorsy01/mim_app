import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_assets.dart';
import 'package:meem_app/Constants/app_enums.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Modules/Authentication/Widgets/selectable_circle_widget.dart';
import 'package:meem_app/Modules/Authentication/Widgets/sp_signup_widget.dart';
import 'package:meem_app/Modules/Authentication/Widgets/user_signup_widget.dart';
import 'package:meem_app/Modules/Authentication/authentication_view_model.dart';
import 'package:provider/provider.dart';

import '/../../../../Constants/app_colors.dart';

class SignupMobileView extends StatefulWidget {
  const SignupMobileView({Key? key}) : super(key: key);

  @override
  _SignupMobileViewState createState() => _SignupMobileViewState();
}

class _SignupMobileViewState extends State<SignupMobileView> {
  late AuthenticationViewModel authViewModel;

  @override
  void initState() {
    authViewModel =
        Provider.of<AuthenticationViewModel>(context, listen: false);
    Future.microtask(() async {
      await authViewModel.spGetListData(context);
    });

    super.initState();
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
        backgroundColor: AppColors.white,
        body: SizedBox(
          height: deviceSize.height,
          child: SizedBox(
            height: deviceSize.height,
            child: authViewModel.secondaryStatus == Status.loading ||
                    authViewModel.spSignupListData == null
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
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
                              fontFamily: AppFonts.cairoFontSemiBold,
                              fontSize: 22.0),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        SelectableText(
                          authViewModel.isUserSelected
                              ? getTranslated(context, "create_user_account")
                              : getTranslated(context, "create_sp_account"),
                          style: const TextStyle(
                              fontFamily: AppFonts.cairoFontRegular,
                              fontSize: 17.0),
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
                        authViewModel.isUserSelected
                            ? const UserSignupWidget()
                            : const SpSignupWidget(),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
