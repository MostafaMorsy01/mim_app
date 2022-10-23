import 'package:flutter/material.dart';
import 'package:meem_app/CommonWidget/custom_checkbox.dart';
import 'package:meem_app/CommonWidget/custom_text_field_widget.dart';
import 'package:meem_app/CommonWidget/dashed_button.dart';
import 'package:meem_app/CommonWidget/location_button.dart';
import 'package:meem_app/CommonWidget/main_button.dart';
import 'package:meem_app/Constants/app_assets.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_enums.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Models/category_model.dart';
import 'package:meem_app/Models/shipping_company_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Authentication/sp_authentication_view_model.dart';
import 'package:meem_app/Services/text_field_validations.dart';
import 'package:provider/provider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class SpSignupMobileView extends StatefulWidget {
  const SpSignupMobileView({Key? key}) : super(key: key);

  @override
  State<SpSignupMobileView> createState() => _SpSignupMobileViewState();
}

class _SpSignupMobileViewState extends State<SpSignupMobileView> {
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

  late SpAuthenticationViewModel authViewModel;

  @override
  void initState() {
    selectedShippingCompanies = [];

    authViewModel =
        Provider.of<SpAuthenticationViewModel>(context, listen: false);
    authViewModel.accountVerificationAttachemnt = "";
    authViewModel.nationalIdAttachemnt = "";
    Future.microtask(() async {
      await authViewModel.spGetListData(context);
    });
    super.initState();
  }

  void _showMultiSelect(
      BuildContext context, List items, List initalItems) async {
    final _items = items
        .map((item) => MultiSelectItem<Category>(item, item.name))
        .toList();
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items: _items,
          initialValue: initalItems,
          onConfirm: (values) {},
        );
      },
    );
  }

  @override
  void dispose() {
    selectedShippingCompanies = [];
    authViewModel.accountVerificationAttachemnt = "";
    authViewModel.nationalIdAttachemnt = "";
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
    final node = FocusScope.of(context);
    authViewModel =
        Provider.of<SpAuthenticationViewModel>(context, listen: true);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Form(
          key: _formKey,
          child: SizedBox(
            height: deviceSize.height,
            child: SizedBox(
              height: deviceSize.height,
              child: authViewModel.status == Status.loading ||
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
                            getTranslated(context, "create_sp_account"),
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
                          SizedBox(
                            width: deviceSize.width * 0.9,
                            child: Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.white,
                                    border: Border.all(
                                        color: AppColors.blue1, width: 2.0),
                                  ),
                                  padding: const EdgeInsets.all(8.5),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SelectableText(
                                    getTranslated(context, "user"),
                                    style: const TextStyle(
                                        fontFamily: AppFonts.cairoFontRegular,
                                        fontSize: 17.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                            width: deviceSize.width * 0.9,
                            child: Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.blue1,
                                    border: Border.all(
                                        color: AppColors.blue1, width: 2.0),
                                  ),
                                  padding: const EdgeInsets.all(8.5),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SelectableText(
                                    getTranslated(context, "service_provider"),
                                    style: const TextStyle(
                                        fontFamily: AppFonts.cairoFontRegular,
                                        fontSize: 17.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
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
                                    storeNameController.text,
                                    context,
                                    "enter_store_name");
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
                              onPressed: () {
                                _showMultiSelect(
                                    context,
                                    authViewModel.spSignupListData!.categories,
                                    []);
                              },
                              icon: AppAssets.fourSquareMenuIcon,
                              onEditingComplete: () {}),
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
                            selectedCities: [],
                            border: true,
                            delete: false,
                            icon: AppAssets.locationIcon,
                            onPressed: () {},
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
                                fileuploadType: FileUploadType.pdf,
                                onPressed: () {
                                  authViewModel.commercialRegisterList
                                      .removeAt(i);
                                  setState(() {});
                                },
                                text: authViewModel.commercialRegisterList[i]
                                    .split('/')
                                    .last,
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
                                    fontFamily: AppFonts.cairoFontRegular,
                                    fontSize: 17.0),
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
                              fileuploadType: FileUploadType.pdf,
                              onPressed: () {
                                authViewModel.nationalIdAttachemnt = "";
                                setState(() {});
                              },
                              text: authViewModel.nationalIdAttachemnt
                                  .split('/')
                                  .last,
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
                                verifiedAccountSelected =
                                    !verifiedAccountSelected;
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
                                    hint: getTranslated(
                                        context, "verified_account_text"),
                                    controller: verifiedAccountUrl,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.text,
                                    icon: AppAssets.userOctagonIcon,
                                    validate: (_) {
                                      return AppValidations
                                          .validateNotEmptyText(
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
                                      getTranslated(
                                          context, "verified_account_document"),
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
                                if (authViewModel
                                        .accountVerificationAttachemnt !=
                                    "")
                                  const SizedBox(
                                    height: 15,
                                  ),
                                if (authViewModel
                                        .accountVerificationAttachemnt !=
                                    "")
                                  FileUploadWidget(
                                    fileuploadType: FileUploadType.png,
                                    onPressed: () {
                                      authViewModel
                                          .accountVerificationAttachemnt = "";
                                      setState(() {});
                                    },
                                    text: authViewModel
                                        .accountVerificationAttachemnt
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
                                    fontFamily: AppFonts.cairoFontRegular,
                                    fontSize: 17.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          for (int i = 0;
                              i <
                                  authViewModel.spSignupListData!
                                      .shippingCompanies.length;
                              i++)
                            CustomCheckbox(
                              text: authViewModel
                                  .spSignupListData!.shippingCompanies[i].name,
                              width: deviceSize.width * 0.9,
                              checkboxSelected: authViewModel.spSignupListData!
                                  .shippingCompanies[i].selected,
                              onChanged: (selected) {
                                setState(() {
                                  authViewModel.spSignupListData!
                                          .shippingCompanies[i].selected =
                                      !authViewModel.spSignupListData!
                                          .shippingCompanies[i].selected;
                                  if (selected) {
                                    selectedShippingCompanies.add(authViewModel
                                        .spSignupListData!
                                        .shippingCompanies[i]);
                                  } else {
                                    selectedShippingCompanies.remove(
                                        authViewModel.spSignupListData!
                                            .shippingCompanies[i]);
                                  }
                                });
                              },
                            ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          MainButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()
                                    // &&
                                    // authViewModel
                                    //     .commercialRegisterList.isNotEmpty &&
                                    // authViewModel.nationalIdAttachemnt !=
                                    //     null
                                    ) {
                                  await authViewModel.spRegisterStore(
                                      storeNameController.text,
                                      emailController.text,
                                      phoneNumberController.text,
                                      passwordController.text,
                                      [1, 2],
                                      selectedShippingCompanies,
                                      [1, 2],
                                      verifiedAccountUrl.text,
                                      context);
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
                              onPressed: () {},
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
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class FileUploadWidget extends StatelessWidget {
  final String text;
  final double width;
  final Function onPressed;
  final FileUploadType fileuploadType;

  const FileUploadWidget({
    Key? key,
    required this.text,
    required this.width,
    required this.onPressed,
    required this.fileuploadType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: AppColors.secondary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 25,
            width: 25,
            child: ImageIcon(
              AssetImage(fileuploadType == FileUploadType.pdf
                  ? AppAssets.documentIcon
                  : AppAssets.galleryIcon),
              color: AppColors.primary,
              size: 25,
            ),
          ),
          const SizedBox(
            width: 7.0,
          ),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              textDirection: TextDirection.ltr,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  height: 1.6,
                  color: AppColors.black,
                  fontFamily: AppFonts.cairoFontRegular,
                  fontSize: 17),
            ),
          ),
          const Spacer(),
          TextButton(
              onPressed: () {
                onPressed();
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  getTranslated(context, "delete"),
                  style: const TextStyle(
                      height: 1.6,
                      fontFamily: AppFonts.cairoFontRegular,
                      fontSize: 17),
                ),
              ))
        ],
      ),
    );
  }
}
