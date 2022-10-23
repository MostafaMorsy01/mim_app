import 'package:flutter/material.dart';
import 'package:meem_app/CommonWidget/custom_checkbox.dart';
import 'package:meem_app/CommonWidget/custom_text_field_widget.dart';
import 'package:meem_app/CommonWidget/dashed_button.dart';
import 'package:meem_app/CommonWidget/location_button.dart';
import 'package:meem_app/CommonWidget/main_button.dart';
import 'package:meem_app/Constants/app_assets.dart';
import 'package:meem_app/Constants/app_enums.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Models/category_model.dart';
import 'package:meem_app/Models/city_model.dart';
import 'package:meem_app/Models/shipping_company_model.dart';
import 'package:meem_app/Modules/Authentication/authentication_navigations.dart';
import 'package:meem_app/Modules/Authentication/authentication_view_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Authentication/Views/Mobile/signup_mobile_view.dart';
import 'package:meem_app/Services/text_field_validations.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

import '../../../Constants/app_colors.dart';

class SpSignupWidget extends StatefulWidget {
  const SpSignupWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SpSignupWidget> createState() => _SpSignupWidgetState();
}

class _SpSignupWidgetState extends State<SpSignupWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController verifiedAccountUrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool obsecureText = true;
  bool checkboxSelected = true;
  bool verifiedAccountSelected = false;
  List<ShippingCompany> selectedShippingCompanies = [];
  List<Category> selectedCategories = [];
  List<City> selectedCities = [];
  late AuthenticationViewModel authViewModel;

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
  void initState() {
    authViewModel =
        Provider.of<AuthenticationViewModel>(context, listen: false);
    authViewModel.accountVerificationAttachemnt = "";
    authViewModel.nationalIdAttachemnt = "";
    selectedCategories = [];
    selectedCities = [];
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    verifiedAccountUrl.dispose();
    storeNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    authViewModel = Provider.of<AuthenticationViewModel>(context, listen: true);
    final node = FocusScope.of(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
              deviceSize: deviceSize,
              hint: getTranslated(context, "email"),
              controller: emailController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              icon: AppAssets.mailIcon,
              validate: (_) {
                return AppValidations.validateEmail(
                    emailController.text, context);
              },
              onEditingComplete: () {
                node.nextFocus();
              }),
          CustomTextField(
              deviceSize: deviceSize,
              hint: getTranslated(context, "store_name"),
              controller: storeNameController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              icon: AppAssets.userTagIcon,
              validate: (_) {
                return AppValidations.validateNotEmptyText(
                    storeNameController.text, context, "enter_store_name");
              },
              onEditingComplete: () {
                node.nextFocus();
              }),
          CustomTextField(
              deviceSize: deviceSize,
              hint: getTranslated(context, "phone_number"),
              controller: phoneNumberController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              icon: AppAssets.lockIcon,
              validate: (_) {
                return AppValidations.validatePhoneNumber(
                    phoneNumberController.text, context);
              },
              onEditingComplete: () {
                node.nextFocus();
              }),
          CustomTextField(
              deviceSize: deviceSize,
              hint: getTranslated(context, "password"),
              controller: passwordController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              obsecure: true,
              validate: (_) {
                return AppValidations.validatePassword(
                    passwordController.text, context);
              },
              icon: AppAssets.lockIcon,
              onEditingComplete: () {
                node.unfocus();
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
                getTranslated(context, "commercial_register"),
                style: const TextStyle(
                    fontFamily: AppFonts.cairoFontRegular, fontSize: 17.0),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          DashedButton(
              onPressed: () {
                authViewModel.pickCommercialRegisterFiles();
              },
              text: getTranslated(context, "upload_pdf"),
              width: deviceSize.width * 0.9),
          const SizedBox(
            height: 15,
          ),
          if (authViewModel.commercialRegisterList.isNotEmpty)
            for (int i = 0;
                i < authViewModel.commercialRegisterList.length;
                i++)
              FileUploadWidget(
                fileuploadType: authViewModel
                            .commercialRegisterListExtensions[i] ==
                        'pdf'
                    ? FileUploadType.pdf
                    : authViewModel.commercialRegisterListExtensions[i] == 'jpg'
                        ? FileUploadType.jpg
                        : FileUploadType.png,
                onPressed: () {
                  authViewModel.commercialRegisterList.removeAt(i);
                  setState(() {});
                },
                text: authViewModel.commercialRegisterList[i].split('/').last,
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
                await authViewModel.pickNationalidFiles();
              },
              text: getTranslated(context, "upload_pdf"),
              width: deviceSize.width * 0.9),
          const SizedBox(
            height: 15,
          ),
          if (authViewModel.nationalIdAttachemnt != "")
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
          CustomCheckbox(
            text: getTranslated(context, "verified_account"),
            width: deviceSize.width * 0.9,
            checkboxSelected: verifiedAccountSelected,
            onChanged: (selected) {
              setState(() {
                verifiedAccountSelected = !verifiedAccountSelected;
              });
            },
          ),
          if (verifiedAccountSelected)
            Column(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                CustomTextField(
                    deviceSize: deviceSize,
                    hint: getTranslated(context, "verified_account_text"),
                    controller: verifiedAccountUrl,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    icon: AppAssets.userOctagonIcon,
                    validate: (_) {
                      return AppValidations.validateNotEmptyText(
                          verifiedAccountUrl.text,
                          context,
                          "enter_account_url");
                    },
                    onEditingComplete: () {
                      node.unfocus();
                    }),
                const SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  width: deviceSize.width * 0.9,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SelectableText(
                      getTranslated(context, "verified_account_document"),
                      style: const TextStyle(
                          fontFamily: AppFonts.cairoFontRegular,
                          fontSize: 17.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DashedButton(
                    onPressed: () {
                      authViewModel.pickAccountverification();
                    },
                    text: getTranslated(context, "upload_pdf"),
                    width: deviceSize.width * 0.9),
                if (authViewModel.accountVerificationAttachemnt != "")
                  const SizedBox(
                    height: 15,
                  ),
                if (authViewModel.accountVerificationAttachemnt != "")
                  FileUploadWidget(
                    fileuploadType: authViewModel
                                .accountVerificationAttachemntExtension ==
                            'pdf'
                        ? FileUploadType.pdf
                        : authViewModel
                                    .accountVerificationAttachemntExtension ==
                                'jpg'
                            ? FileUploadType.jpg
                            : FileUploadType.png,
                    onPressed: () {
                      authViewModel.accountVerificationAttachemnt = "";
                      setState(() {});
                    },
                    text: authViewModel.accountVerificationAttachemnt
                        .split('/')
                        .last,
                    width: deviceSize.width * 0.9,
                  ),
              ],
            ),
          const SizedBox(
            height: 30.0,
          ),
          SizedBox(
            width: deviceSize.width * 0.9,
            child: Align(
              alignment: Alignment.centerRight,
              child: SelectableText(
                getTranslated(context, "official_shipping"),
                style: const TextStyle(
                    fontFamily: AppFonts.cairoFontRegular, fontSize: 17.0),
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          for (int i = 0;
              i < authViewModel.spSignupListData!.shippingCompanies.length;
              i++)
            CustomCheckbox(
              text: authViewModel.spSignupListData!.shippingCompanies[i].name,
              width: deviceSize.width * 0.9,
              checkboxSelected:
                  authViewModel.spSignupListData!.shippingCompanies[i].selected,
              onChanged: (selected) {
                setState(() {
                  authViewModel
                          .spSignupListData!.shippingCompanies[i].selected =
                      !authViewModel
                          .spSignupListData!.shippingCompanies[i].selected;
                  if (selected) {
                    selectedShippingCompanies.add(
                        authViewModel.spSignupListData!.shippingCompanies[i]);
                  } else {
                    selectedShippingCompanies.remove(
                        authViewModel.spSignupListData!.shippingCompanies[i]);
                  }
                });
              },
            ),
          const SizedBox(
            height: 30.0,
          ),
          authViewModel.status == Status.loading
              ? const CircularProgressIndicator(
                  color: AppColors.primary,
                )
              : MainButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool result = await authViewModel.spRegisterStore(
                          storeNameController.text,
                          emailController.text,
                          phoneNumberController.text,
                          passwordController.text,
                          selectedCities,
                          selectedShippingCompanies,
                          selectedCategories,
                          verifiedAccountUrl.text,
                          context);
                      if (result) {
                        AuthenticationNavigations.phoneVerificationNavigation(
                            context, "store");
                      }
                    }
                  },
                  text: getTranslated(context, "create_account"),
                  width: deviceSize.width * 0.9),
          const SizedBox(
            height: 30.0,
          ),
          SizedBox(
            width: deviceSize.width * 0.9,
            child: TextButton(
              onPressed: () {
                AuthenticationNavigations.loginNavigation(context);
              },
              child: Text(
                getTranslated(context, "already_have_account"),
                style: const TextStyle(
                    height: 1.6,
                    color: AppColors.primary,
                    fontFamily: AppFonts.cairoFontLight,
                    fontSize: 20),
              ),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
        ],
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
