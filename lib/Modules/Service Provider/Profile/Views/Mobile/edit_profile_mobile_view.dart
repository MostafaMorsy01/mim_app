import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_assets.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Modules/Authentication/authentication_view_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Profile/Views/Mobile/update_sp_profile_mobile_view.dart';
import 'package:meem_app/Modules/Service%20Provider/Profile/Views/customer_reviews_view.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Views/my_products_view.dart';
import 'package:meem_app/Modules/Service%20Provider/Profile/Views/payment_options_view.dart';
import 'package:meem_app/Modules/Service%20Provider/Profile/Views/shipping_options_view.dart';
import 'package:meem_app/Modules/Service%20Provider/Profile/Views/subscription_view.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../../CommonWidget/custom_text_field_widget.dart';
import '../../../../../CommonWidget/main_button.dart';
import '../../../../../CommonWidget/title_appbar.dart';
import '../../../../../Constants/app_enums.dart';
import '../../../../../Services/text_field_validations.dart';
import '../../../../Authentication/Views/Mobile/forget_password_mobile_view.dart';
import '../../../../Profile/ProfileEdit/ViewModel/profile_view_model.dart';
import '../../ViewModel/sp_profile_view_model.dart';

class EditSpProfileMobileView extends StatefulWidget {
  const EditSpProfileMobileView({Key? key}) : super(key: key);
  static String id = 'sp_profileScreen';

  @override
  State<EditSpProfileMobileView> createState() => _EditSpProfileMobileViewState();
}

class _EditSpProfileMobileViewState extends State<EditSpProfileMobileView> {
  late SpProfileViewModel sp_profileViewModel;
  bool isVisible1 = false;
  late AuthenticationViewModel authViewModel;
  bool isShowImg = false;

  @override
  void initState() {
    sp_profileViewModel = Provider.of<SpProfileViewModel>(context, listen: false);
    Future(() async {
      await sp_profileViewModel.FetchingProfileData(context);
    });
    callThisMethod(isVisible1);
    authViewModel =
        Provider.of<AuthenticationViewModel>(context, listen: false);
    super.initState();
  }

  void callThisMethod(bool isVisible) {
    debugPrint('_UpdateProfile.callThisMethod: isVisible: ${isVisible}');
    if (isVisible) {
      sp_profileViewModel.FetchingProfileData(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    sp_profileViewModel = Provider.of<SpProfileViewModel>(context, listen: true);
    authViewModel =
        Provider.of<AuthenticationViewModel>(context, listen: true);
    return VisibilityDetector(
      key: Key(EditSpProfileMobileView.id),
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
                          SpUpdateProfileMobileView(profileCore: sp_profileViewModel.sp_profileCore!,)
                  ));


            },
          ),
          elevation: 0,
        ),
        body: SafeArea(
          child: sp_profileViewModel.secondaryStatus == Status.loading ||
              sp_profileViewModel.sp_profileCore == null
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
                                sp_profileViewModel.sp_profileCore?.store?.email ??
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
                              AppAssets.areaIcon,

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
                                getTranslated(context, "area"),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily: AppFonts.cairoFontSemiBold,
                                    fontSize: 15),
                              ),
                             Row(
                               children: [
                                 ...List.generate(sp_profileViewModel.sp_profileCore?.store?.cities?.length ?? 0, (index) =>  Row(
                                   children: [
                                     Padding(
                                       padding: const EdgeInsets.all(3.0),
                                       child: Text(
                                         sp_profileViewModel.sp_profileCore?.store?.cities?[index].name ??
                                             "",
                                         textAlign: TextAlign.start,
                                         style: TextStyle(
                                             fontFamily: AppFonts.cairoFontSemiBold,
                                             fontSize: 15),
                                       ),
                                     ),
                                   ],
                                 ),)
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
                              AppAssets.catIcon,

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
                                getTranslated(context, "category"),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily: AppFonts.cairoFontSemiBold,
                                    fontSize: 15),
                              ),
                             Row(
                               children: [
                                 ...List.generate(sp_profileViewModel.sp_profileCore?.store?.categories?.length ?? 0, (index) =>  Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   children: [
                                     Padding(
                                       padding: const EdgeInsets.all(3.0),
                                       child: Text(
                                         sp_profileViewModel.sp_profileCore?.store?.categories?[index].name ??
                                             "",
                                         textAlign: TextAlign.start,
                                         style: TextStyle(
                                             fontFamily: AppFonts.cairoFontSemiBold,
                                             fontSize: 15),
                                       ),
                                     ),
                                   ],
                                 ),)
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
                                sp_profileViewModel.sp_profileCore?.store?.phone ??
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
              Container(
                height: 80,
                width: deviceSize.width * 0.9,
                margin: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.01),
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: AppColors.secondary,

                ),
                child: Row(

                  children: [
                    ImageIcon(
                      AssetImage(
                        AppAssets.documentIcon,

                      ),
                      color: AppColors.primary,
                      size: 40,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                    getTranslated(context, "commercial_register"),
                      style: const TextStyle(
                          height: 1.6,
                          color: AppColors.black,
                          fontFamily: AppFonts.cairoFontRegular,
                          fontSize: 12),
                    ),
                   Spacer(),
                    TextButton(
                      onPressed: () {

                      },
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          getTranslated(context, "open_img"),
                          style: const TextStyle(
                              height: 1.6,
                              color: AppColors.primary,
                              fontFamily: AppFonts.cairoFontRegular,
                              fontSize: 15),
                        ),
                      ),
                    )


                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 80,
                width: deviceSize.width * 0.9,
                margin: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.01),
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: AppColors.secondary,

                ),
                child: Row(

                  children: [
                    ImageIcon(
                      AssetImage(
                        AppAssets.documentIcon,

                      ),
                      color: AppColors.primary,
                      size: 40,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      getTranslated(context, "national_id"),
                      style: const TextStyle(
                          height: 1.6,
                          color: AppColors.black,
                          fontFamily: AppFonts.cairoFontRegular,
                          fontSize: 12),
                    ),
                   Spacer(),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isShowImg = true;
                        });
                      },
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          getTranslated(context, "open_img"),
                          style: const TextStyle(
                              height: 1.6,
                              color: AppColors.primary,
                              fontFamily: AppFonts.cairoFontRegular,
                              fontSize: 15),
                        ),
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

