import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Profile/Views/Mobile/profile_mobile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../Model/profile_core_model.dart';
import 'Mobile/edit_profile_mobile_view.dart';
import 'Mobile/update_profile_mobile_view.dart';

class EditProfileView extends StatelessWidget {
  static const routeName = '/profile';
  final ProfileCoreModel? profileCore;
  const EditProfileView({Key? key, required this.profileCore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile:  EditProfileMobileView(profileCore: profileCore,),
      tablet:  EditProfileMobileView(profileCore: profileCore,),
    );
  }
}
