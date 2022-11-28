import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_assets.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Modules/Address/Views/address_list_view.dart';
import 'package:meem_app/Modules/Authentication/Views/Mobile/forget_password_mobile_view.dart';
import 'package:meem_app/Modules/Authentication/authentication_view_model.dart';
import 'package:meem_app/Modules/Profile/ProfileEdit/ViewModel/profile_view_model.dart';
import 'package:meem_app/Modules/Profile/ProfileEdit/Views/Mobile/edit_profile_mobile_view.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../../CommonWidget/title_appbar.dart';
import '../../../../../Constants/app_enums.dart';
import '../../../../Authentication/authentication_navigations.dart';
import '../edit_profile_view.dart';

class UpdateProfileMobileView extends StatefulWidget {
  const UpdateProfileMobileView({Key? key}) : super(key: key);
  static String id = 'profileScreen';

  @override
  State<UpdateProfileMobileView> createState() =>
      _UpdateProfileMobileViewState();
}

class _UpdateProfileMobileViewState extends State<UpdateProfileMobileView> {
  late ProfileViewModel profileViewModel;
  bool isVisible1 = false;
  late AuthenticationViewModel authViewModel;

  @override
  void initState() {
    profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    Future(() async {
      await profileViewModel.FetchingProfileData(context);
    });
    callThisMethod(isVisible1);
    authViewModel =
        Provider.of<AuthenticationViewModel>(context, listen: false);
    super.initState();
  }

  void callThisMethod(bool isVisible) {
    debugPrint('_UpdateProfile.callThisMethod: isVisible: ${isVisible}');
    if (isVisible) {
      profileViewModel.FetchingProfileData(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    profileViewModel = Provider.of<ProfileViewModel>(context, listen: true);
    authViewModel =
        Provider.of<AuthenticationViewModel>(context, listen: true);
    return VisibilityDetector(
        key: Key(UpdateProfileMobileView.id),
        onVisibilityChanged: (VisibilityInfo info) {
          bool isVisible = info.visibleFraction != 0;
          callThisMethod(isVisible);
        },
      child:Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: TitleAppBar(
            title: getTranslated(context, "profile"),
            buttonTitle: getTranslated(context, "edit_profile"),
            onPrssed: (){
              print("pressed");
              // print(AddProductView.routeName);
              // Navigator.of(context).pushNamed(AddProductView.routeName);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EditProfileView(profileCore: profileViewModel.profileCore!,)
                  ));


            },
          ),
          elevation: 0,
        ),
      body: SafeArea(
        child: profileViewModel.secondaryStatus == Status.loading ||
                profileViewModel.profileCore == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: Row(
                           mainAxisAlignment:MainAxisAlignment.start ,
                            children: [
                              ImageIcon(
                                AssetImage(
                                  AppAssets.emailIcon,

                                ),
                                color: AppColors.primary,
                                size: 40,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Text(
                                    getTranslated(context, "email"),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: AppFonts.cairoFontSemiBold,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    profileViewModel.profileCore?.user?.email ??
                                        "",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: AppFonts.cairoFontSemiBold,
                                        fontSize: 15),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: Row(
                            mainAxisAlignment:MainAxisAlignment.start ,
                            children: [
                              ImageIcon(
                                AssetImage(
                                  AppAssets.phoneIcon,

                                ),
                                color: AppColors.primary,
                                size: 40,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Text(
                                    getTranslated(context, "phone_number"),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: AppFonts.cairoFontSemiBold,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    profileViewModel.profileCore?.user?.phone ??
                                        "",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: AppFonts.cairoFontSemiBold,
                                        fontSize: 15),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: Row(
                            mainAxisAlignment:MainAxisAlignment.start ,
                            children: [
                              ImageIcon(
                                AssetImage(
                                  AppAssets.passwordIcon,

                                ),
                                color: AppColors.primary,
                                size: 40,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    getTranslated(context, "password"),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: AppFonts.cairoFontSemiBold,
                                        fontSize: 15),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "***************",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontFamily: AppFonts.cairoFontSemiBold,
                                            fontSize: 15),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForgetPasswordMobileView(userType: authViewModel.isUserSelected ? "user" : "store",)
                                              ));
                                        },
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            getTranslated(context, "new_password"),
                                            style: TextStyle(
                                                fontFamily: AppFonts.cairoFontBold,
                                                fontSize: 15,
                                                // ignore: prefer_if_null_operators
                                                color: AppColors.primary),
                                          ),
                                        ),
                                      ),

                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    ),);
  }
}

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.img,
  }) : super(key: key);

  final Function onPressed;
  final String text;
  final String img;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12.5)),
            child: ImageIcon(
              AssetImage(
                img,
              ),
              color: AppColors.primary,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
                fontFamily: AppFonts.cairoFontSemiBold,
                fontSize: 18,
                height: 1.2,
                color: AppColors.black),
          )
        ],
      ),
    );
  }
}
