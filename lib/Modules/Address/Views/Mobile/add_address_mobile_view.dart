import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_enums.dart';
import 'package:meem_app/Modules/Address/ViewModel/address_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../CommonWidget/custom_text_field_widget.dart';
import '../../../../CommonWidget/main_button.dart';
import '../../../../CommonWidget/title_appbar.dart';
import '../../../../CommonWidget/toast.dart';
import '../../../../Constants/app_assets.dart';
import '../../../../Constants/app_colors.dart';
import '../../../../Localization/app_localization.dart';
import '../../../../Models/sp_signup_list_data_model.dart';
import '../../../../Services/text_field_validations.dart';

class AddAddressMobileView extends StatefulWidget {
  final SpSignupListData? listData;

  const AddAddressMobileView({Key? key, required this.listData})
      : super(key: key);

  @override
  State<AddAddressMobileView> createState() => _AddAddressMobileViewState();
}

class _AddAddressMobileViewState extends State<AddAddressMobileView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController specialMarkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AddressViewModel addressViewModel;
  String? selectedValue;

  @override
  void initState() {
    // TODO: implement initState
    addressViewModel = Provider.of<AddressViewModel>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    areaController.dispose();
    streetController.dispose();
    specialMarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    addressViewModel = Provider.of<AddressViewModel>(context, listen: true);
    final node = FocusScope.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: TitleAppBar(
          title: getTranslated(context, "new_Address"),
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
                      hint: getTranslated(context, "name_address"),
                      controller: nameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      icon: AppAssets.userTagIcon,
                      validate: (_) {
                        return AppValidations.validateNotEmptyText(
                            nameController.text, context, "name_address_error");
                      },
                      onEditingComplete: () {
                        node.nextFocus();
                      }),
                  CustomTextField(
                      deviceSize: deviceSize,
                      hint: getTranslated(context, "area_address"),
                      controller: areaController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      icon: AppAssets.userTagIcon,
                      validate: (_) {
                        return AppValidations.validateNotEmptyText(
                            areaController.text, context, "area_address_error");
                      },
                      onEditingComplete: () {
                        node.nextFocus();
                      }),
                  CustomTextField(
                      deviceSize: deviceSize,
                      hint: getTranslated(context, "street"),
                      controller: streetController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      icon: AppAssets.userTagIcon,
                      validate: (_) {
                        return AppValidations.validateNotEmptyText(
                            streetController.text, context, "street_error");
                      },
                      onEditingComplete: () {
                        node.nextFocus();
                      }),
                  DropdownButtonHideUnderline(
                    child: DropdownButtonFormField2(
                      isExpanded: true,
                      hint: Row(
                        children: [
                          Icon(
                            Icons.list,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Text(
                              getTranslated(context, "city"),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: widget.listData!.cities
                          .map((item) => DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: Text(
                                  item.name ?? "",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onSaved: (value) {
                        selectedValue = value;
                        // catId = int.parse(value!);
                        // catId = selectedValue.to
                      },
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                          // catId = value as int;

                          print(selectedValue);
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor: AppColors.primary,
                      iconDisabledColor: Colors.white,
                      buttonHeight: 50,
                      buttonWidth: deviceSize.width - 50,
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppColors.primary,
                        ),
                        color: AppColors.white,
                      ),
                      buttonElevation: 2,
                      itemHeight: 40,
                      itemPadding: const EdgeInsets.only(left: 14, right: 14),
                      dropdownMaxHeight: 200,
                      dropdownWidth: 200,
                      dropdownPadding: null,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                      ),
                      dropdownElevation: 8,
                      scrollbarRadius: const Radius.circular(40),
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                      offset: const Offset(-20, 0),
                    ),
                  ),
                  CustomTextField(
                      deviceSize: deviceSize,
                      hint: getTranslated(context, "special_mark"),
                      controller: specialMarkController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      icon: AppAssets.userTagIcon,
                      validate: (_) {
                        return AppValidations.validateNotEmptyText(
                            specialMarkController.text,
                            context,
                            "special_mark_error");
                      },
                      onEditingComplete: () {
                        node.nextFocus();
                      }),
                  SizedBox(
                      height: deviceSize.height * 0.244,
                      child: Column(
                        children: [
                          SizedBox(
                            height: deviceSize.height * 0.084,
                            child: addressViewModel.status == Status.loading
                                ? Center(
                                    child: const CircularProgressIndicator(
                                        color: AppColors.primary))
                                : MainButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate() &&
                                          selectedValue != "") {
                                        bool result =
                                            await addressViewModel.addAddress(
                                                nameController.text
                                                    .toString(),
                                                areaController.text
                                                    .toString(),
                                                int.parse(selectedValue!),
                                                streetController.text
                                                    .toString(),
                                                specialMarkController.text
                                                    .toString(),
                                                context);
                                        if (result) {
                                          toastAppSuccess(
                                              "Address Added Successfully",
                                              contest: context);
                                        } else {
                                          toastAppErr(
                                              "Address does not add Successfully ",
                                              contest: context);
                                        }
                                      }
                                    },
                                    text:
                                        getTranslated(context, "new_Address"),
                                    width: deviceSize.width * 0.9),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
