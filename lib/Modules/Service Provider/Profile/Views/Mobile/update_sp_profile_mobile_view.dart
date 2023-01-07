import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';

import '../../../../../CommonWidget/custom_text_field_widget.dart';
import '../../../../../CommonWidget/dashed_button.dart';
import '../../../../../CommonWidget/location_button.dart';
import '../../../../../CommonWidget/main_button.dart';
import '../../../../../CommonWidget/title_appbar.dart';
import '../../../../../CommonWidget/toast.dart';
import '../../../../../Constants/app_assets.dart';
import '../../../../../Constants/app_colors.dart';
import '../../../../../Constants/app_enums.dart';
import '../../../../../Constants/app_fonts.dart';
import '../../../../../Localization/app_localization.dart';
import '../../../../../Models/category_model.dart';
import '../../../../../Models/city_model.dart';
import '../../../../../Services/text_field_validations.dart';
import '../../../../Authentication/authentication_view_model.dart';
import '../../../Authentication/Views/Mobile/signup_mobile_view.dart';
import '../../Model/sp_profile_core_model.dart';
import '../../ViewModel/sp_profile_view_model.dart';

class SpUpdateProfileMobileView extends StatefulWidget {
  final SpProfileCoreModel? profileCore;

  const SpUpdateProfileMobileView({Key? key, required this.profileCore})
      : super(key: key);

  @override
  State<SpUpdateProfileMobileView> createState() => _SpUpdateProfileMobileViewState();
}

class _SpUpdateProfileMobileViewState extends State<SpUpdateProfileMobileView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  late SpProfileViewModel profileViewModel;
  late AuthenticationViewModel authViewModel;

  final _formKey = GlobalKey<FormState>();
  bool obsecureText = true;
  List<Category> selectedCategories = [];
  List<City> selectedCities = [];

  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    profileViewModel = Provider.of<SpProfileViewModel>(context, listen: false);
    authViewModel =
        Provider.of<AuthenticationViewModel>(context, listen: false);
    Future(() async {
      await authViewModel.spGetListData(context);
    });
    super.initState();
  }
  void _showMultiSelect(BuildContext context, List<MultiSelectItem> items,
      List initalItems, String title, MultiSelectObjectType objectType) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items: items,
          itemsTextStyle: const TextStyle(
            color: AppColors.black,
            fontFamily: AppFonts.cairoFontRegular,
            fontSize: 16.0,
          ),
          title: Text(
            getTranslated(context, title),
            style: const TextStyle(
              color: AppColors.blue1,
              fontFamily: AppFonts.cairoFontRegular,
              fontSize: 20.0,
            ),
          ),
          cancelText: Text(
            getTranslated(context, "cancel"),
            style: const TextStyle(
              color: AppColors.declinedRed,
              fontFamily: AppFonts.cairoFontRegular,
              fontSize: 17.0,
            ),
          ),
          confirmText: Text(
            getTranslated(context, "confirm"),
            style: const TextStyle(
              color: AppColors.blue1,
              fontFamily: AppFonts.cairoFontRegular,
              fontSize: 17.0,
            ),
          ),
          initialValue: initalItems,
          onConfirm: (values) {
            if (objectType == MultiSelectObjectType.category) {
              selectedCategories = List<Category>.from(values);
            } else {
              selectedCities = List<City>.from(values);
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final node = FocusScope.of(context);
    authViewModel = Provider.of<AuthenticationViewModel>(context, listen: true);
    profileViewModel = Provider.of<SpProfileViewModel>(context, listen: true);
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
                      hint: getTranslated(context, "name"),
                      controller: emailController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.name,
                      icon: AppAssets.userTagIcon,
                      validate: (_) {
                        return AppValidations.validateNotEmptyText(
                            emailController.text,
                            context,
                            "enter_your_name");
                      },
                      onEditingComplete: () {
                        node.nextFocus();
                      }),
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
                  CustomTextField(
                      deviceSize: deviceSize,
                      hint: getTranslated(context, "choose_category"),
                      controller: TextEditingController(),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      obsecure: true,
                      validate: (_) {},
                      readOnly: true,
                      onPressed: () {
                        _showMultiSelect(
                            context,
                            authViewModel.spSignupListData!.categories
                                .map((item) =>
                                MultiSelectItem<Category>(item, item.name))
                                .toList(),
                            selectedCategories,
                            "choose_category_2",
                            MultiSelectObjectType.category);
                      },
                      icon: AppAssets.fourSquareMenuIcon,
                      suffixIcon: AppAssets.dropDownIcon,
                      onEditingComplete: () {}),
                  SizedBox(
                    width: deviceSize.width * 0.9,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Wrap(
                        spacing: 8.0, // gap between adjacent chips
                        runSpacing: 0.0, // gap between lines
                        children: getChipsWidgets(selectedCategories),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Divider(
                    color: AppColors.grey159,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  LocationButton(
                    selectedCities: selectedCities,
                    border: true,
                    delete: false,
                    icon: AppAssets.locationIcon,
                    onPressed: () {
                      _showMultiSelect(
                          context,
                          authViewModel.spSignupListData!.cities
                              .map((item) => MultiSelectItem<City>(item, item.name))
                              .toList(),
                          selectedCities,
                          "choose_city",
                          MultiSelectObjectType.city);
                    },
                    text: getTranslated(context, "area"),
                    width: deviceSize.width * 0.9,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: deviceSize.width * 0.9,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SelectableText(
                        getTranslated(context, "national_id"),
                        style: const TextStyle(
                            fontFamily: AppFonts.cairoFontRegular, fontSize: 17.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    color: AppColors.grey159,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  DashedButton(
                      onPressed: () async {
                        await profileViewModel.pickNationalidFiles();
                      },
                      text: getTranslated(context, "upload_pdf"),
                      width: deviceSize.width * 0.9),
                  const SizedBox(
                    height: 15,
                  ),
                  if (profileViewModel.nationalIdAttachemnt != "")
                    FileUploadWidget(
                      fileuploadType:
                      authViewModel.nationalIdAttachemntExtension == 'pdf'
                          ? FileUploadType.pdf
                          : authViewModel.nationalIdAttachemntExtension == 'jpg'
                          ? FileUploadType.jpg
                          : FileUploadType.png,
                      onPressed: () {
                        authViewModel.nationalIdAttachemnt = "";
                        setState(() {});
                      },
                      text: authViewModel.nationalIdAttachemnt.split('/').last,
                      width: deviceSize.width * 0.9,
                    ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: deviceSize.width * 0.9,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SelectableText(
                        getTranslated(context, "store_img"),
                        style: const TextStyle(
                            fontFamily: AppFonts.cairoFontRegular, fontSize: 17.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    color: AppColors.grey159,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  DashedButton(
                      onPressed: () async {
                        await profileViewModel.pickStoreFiles();
                      },
                      text: getTranslated(context, "upload_pdf"),
                      width: deviceSize.width * 0.9),
                  const SizedBox(
                    height: 15,
                  ),
                  if (profileViewModel.storePhotoAttachemnt != "")
                    FileUploadWidget(
                      fileuploadType:
                      authViewModel.storePhotoAttachemntExtension == 'pdf'
                          ? FileUploadType.pdf
                          : authViewModel.storePhotoAttachemntExtension == 'jpg'
                          ? FileUploadType.jpg
                          : FileUploadType.png,
                      onPressed: () {
                        authViewModel.storePhotoAttachemnt = "";
                        setState(() {});
                      },
                      text: authViewModel.storePhotoAttachemnt.split('/').last,
                      width: deviceSize.width * 0.9,
                    ),
                  const SizedBox(
                    height: 25,
                  ),

                  SizedBox(
                    height: deviceSize.height * 0.084,
                    child: profileViewModel.status == Status.loading
                        ? const Center(child: CircularProgressIndicator())
                        : MainButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            bool result =
                            await profileViewModel.editProfileInfo(
                                nameController.text.toString(),
                                emailController.text.toString(),
                                phoneController.text.toString(),
                                selectedCities,
                                selectedCategories,
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
  List<Widget> getChipsWidgets(List<Category> options) {
    List<Widget> list = [];

    for (var element in options) {
      list.add(Chip(
        label: Text(
          element.name,
          style: const TextStyle(color: AppColors.primary),
        ),
        backgroundColor: AppColors.secondary,
        deleteIcon: const Icon(
          Icons.close,
          size: 20,
          color: AppColors.primary,
        ),
        onDeleted: () {
          setState(() {
            selectedCategories.remove(element);
          });
        },
      ));
    }
    return list;
  }
}