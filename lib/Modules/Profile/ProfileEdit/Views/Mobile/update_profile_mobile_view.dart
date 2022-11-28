import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_assets.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Modules/Address/Views/address_list_view.dart';
import 'package:meem_app/Modules/Authentication/authentication_view_model.dart';
import 'package:meem_app/Modules/Profile/ProfileEdit/ViewModel/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../CommonWidget/title_appbar.dart';
import '../../../../../Constants/app_enums.dart';

class UpdateProfileMobileView extends StatefulWidget {
  const UpdateProfileMobileView({Key? key}) : super(key: key);

  @override
  State<UpdateProfileMobileView> createState() =>
      _UpdateProfileMobileViewState();
}

class _UpdateProfileMobileViewState extends State<UpdateProfileMobileView> {
  late ProfileViewModel profileViewModel;
  bool isVisible1 = false;

  @override
  void initState() {
    profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    Future(() async {
      await profileViewModel.FetchingProfileData(context);
    });
    callThisMethod(isVisible1);
    super.initState();
  }

  void callThisMethod(bool isVisible) {
    debugPrint('_FavouriteScreen.callThisMethod: isVisible: ${isVisible}');
    if (isVisible) {
      profileViewModel.FetchingProfileData(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    profileViewModel = Provider.of<ProfileViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: TitleAppBar(
          title: getTranslated(context, "profile"),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: profileViewModel.secondaryStatus == Status.loading ||
                profileViewModel.profileCore == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(profileViewModel.profileCore?.user?.name ?? "")
                ],
              ),
      ),
    );
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
