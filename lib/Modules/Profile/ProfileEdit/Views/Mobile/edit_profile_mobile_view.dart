import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Profile/ProfileEdit/Model/profile_core_model.dart';
import 'package:meem_app/Modules/Profile/ProfileEdit/ViewModel/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../CommonWidget/custom_text_field_widget.dart';
import '../../../../../CommonWidget/main_button.dart';
import '../../../../../CommonWidget/title_appbar.dart';
import '../../../../../CommonWidget/toast.dart';
import '../../../../../Constants/app_assets.dart';
import '../../../../../Constants/app_enums.dart';
import '../../../../../Localization/app_localization.dart';
import '../../../../../Services/text_field_validations.dart';

class EditProfileMobileView extends StatefulWidget {
  final ProfileCoreModel? profileCore;

  const EditProfileMobileView({Key? key, required this.profileCore})
      : super(key: key);

  @override
  State<EditProfileMobileView> createState() => _EditProfileMobileViewState();
}

class _EditProfileMobileViewState extends State<EditProfileMobileView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  late ProfileViewModel profileViewModel;

  final _formKey = GlobalKey<FormState>();
  bool obsecureText = true;

  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final node = FocusScope.of(context);
    profileViewModel = Provider.of<ProfileViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: TitleAppBar(
          title: getTranslated(context, "edit_profile_title"),
        ),
        elevation: 0,
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Column(
                children: [
                  CustomTextField(
                      deviceSize: deviceSize,
                      hint: getTranslated(context, "email"),
                      controller: emailController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                      icon: AppAssets.userTagIcon,
                      validate: (_) {
                        return AppValidations.validateNotEmptyText(
                            emailController.text,
                            context,
                            "enter_an_mail_address");
                      },
                      onEditingComplete: () {
                        node.nextFocus();
                      }),
                  CustomTextField(
                      deviceSize: deviceSize,
                      hint: getTranslated(context, "phone_number"),
                      controller: phoneController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.phone,
                      icon: AppAssets.userTagIcon,
                      validate: (_) {
                        return AppValidations.validateNotEmptyText(
                            phoneController.text,
                            context,
                            "enter_a_phone_number");
                      },
                      onEditingComplete: () {
                        node.nextFocus();
                      }),
                  SizedBox(
                    height: deviceSize.height * 0.084,
                    child: profileViewModel.status == Status.loading
                        ? const Center(child: CircularProgressIndicator())
                        : MainButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                bool result =
                                    await profileViewModel.editProfileInfo(
                                        emailController.text.toString(),
                                        phoneController.text.toString(),
                                        widget.profileCore!.user!.name ?? "",
                                        context);
                                if (result) {
                                  toastAppSuccess("Profile Update Successfully",
                                      contest: context);
                                } else {
                                  toastAppErr("Profile Did not Update",
                                      contest: context);
                                }
                              }
                            },
                            text: getTranslated(context, "edit_profile_title"),
                            width: deviceSize.width * 0.9),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
