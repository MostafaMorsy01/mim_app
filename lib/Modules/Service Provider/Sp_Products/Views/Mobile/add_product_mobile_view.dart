import 'dart:ffi';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Model/sp_specification_core_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/ViewModel/sp_add_product_view_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Views/add_product_view.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../CommonWidget/custom_text_field_widget.dart';
import '../../../../../CommonWidget/dashed_button.dart';
import '../../../../../CommonWidget/main_button.dart';
import '../../../../../CommonWidget/title_appbar.dart';
import '../../../../../CommonWidget/toast.dart';
import '../../../../../Constants/app_assets.dart';
import '../../../../../Constants/app_enums.dart';
import '../../../../../Constants/app_fonts.dart';
import '../../../../../Localization/app_localization.dart';
import '../../../../../Services/text_field_validations.dart';
import '../../../Authentication/Views/Mobile/signup_mobile_view.dart';
import '../../Model/sp_categories_core_model.dart';
import '../../Model/specification_model.dart';

class AddProductMobileView extends StatefulWidget {
  final SpecificationCoreModel? specCore;
  final CategoriesCoreModel? catCore;

  const AddProductMobileView(
      {Key? key, required this.specCore, required this.catCore})
      : super(key: key);

  @override
  State<AddProductMobileView> createState() => _AddProductMobileViewState();
}

class _AddProductMobileViewState extends State<AddProductMobileView> {
  TextEditingController nameProductController = TextEditingController();
  TextEditingController nameArProductController = TextEditingController();
  TextEditingController qtyProductController = TextEditingController();
  TextEditingController descriptionProductController = TextEditingController();
  TextEditingController priceProductController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obsecureText = true;
  bool checkboxSelected = true;
  bool verifiedAccountSelected = false;
  String? selectedValue;
  String? selectedSize = "";
  int? catId;
  List<int> selectedIndexes = [];
  List<int> _selectedValues = [];
  late SpAddProductViewModel addProductViewModel;


  final ImagePicker imagePicker = ImagePicker();

  List<Asset> images = [];
  String _error = 'No Error Dectected';

  // void selectImages() async {
  //   List<XFile>? selectedImages = await imagePicker.pickMultiImage();
  //   print("hello");
  //   print(selectedImages);
  //   print(imageFileList);
  //   if (selectedImages.isNotEmpty) {
  //     imageFileList.addAll(selectedImages);
  //     addProductViewModel.imagesList.addAll(imageFileList);
  //     print(imageFileList);
  //   }
  //
  //   setState(() {});
  // }
  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultipleImagesPicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),

      );
      if (resultList.isNotEmpty){
        images.addAll(resultList);
        addProductViewModel.imagesList.addAll(images);
        // addProductViewModel.commercialRegisterList = resultList.paths.map((path) => path!).toList();
        // addProductViewModel.commercialRegisterListExtensions =
        //     result.files.map((file) => file.extension!).toList();
      }

    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }
  final controller = MultiImagePickerController(
    maxImages: 10,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return Padding(
          padding:
          const EdgeInsets
              .only(
              top: 10.0,
              right: 10,
              left: 10),
          child: Stack(
            children: [
              Positioned(child: Container(

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: AssetThumb(
                    asset: asset,
                    width: 300,
                    height: 300,
                  ),
                ),
              )),
              Positioned(
                  top: 10,
                  right: 10,
                  left: 10,
                  bottom: 10,
                  child:
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors
                        .grey
                        .withOpacity(
                        0.4),
                    foregroundColor:
                    Colors
                        .white,
                    child:
                    IconButton(
                      icon: Icon(
                        Icons
                            .delete_forever_outlined,
                        size: 20,
                        color: Colors
                            .white,
                      ),
                      onPressed:
                          () {
                        setState(
                                () {
                              images
                                  .removeAt(index);
                              print(
                                  images);
                            });
                      },
                    ),
                  )),
            ],
          ),
        );
      }),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    nameProductController.dispose();
    nameArProductController.dispose();
    qtyProductController.dispose();
    priceProductController.dispose();
    descriptionProductController.dispose();
    controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    // _selectedValues = widget.specCore.specifications
    addProductViewModel =
        Provider.of<SpAddProductViewModel>(context, listen: false);
    selectedIndexes = _selectedValues;


    super.initState();
  }

  Widget SpecialValues(
      String? name, int? id, bool isSelected, int index, List<Values>? values) {
    return InkWell(
      onTap: () {
        setState(() {
          // isSelected = !isSelected;
          values![index].isSelected = !values[index].isSelected;
          if (values[index].isSelected == true) {
            _selectedValues.add(id!);
          } else if (values[index].isSelected == false) {
            _selectedValues.removeWhere((element) => element == id);
          }
          print(_selectedValues);
        });
      },
      child: Container(
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: isSelected ? AppColors.primary : Colors.grey[100]!,
            shape: BoxShape.rectangle),
        child: Center(
          child: Text(
            name!,
            style: const TextStyle(
                fontFamily: AppFonts.cairoFontRegular, fontSize: 15),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    addProductViewModel =
        Provider.of<SpAddProductViewModel>(context, listen: true);
    final deviceSize = MediaQuery.of(context).size;


    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: TitleAppBar(
          title: getTranslated(context, "add_product"),
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
                      hint: getTranslated(context, "product_name_en"),
                      controller: nameProductController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      icon: AppAssets.userTagIcon,
                      validate: (_) {
                        return AppValidations.validateNotEmptyText(
                            nameProductController.text,
                            context,
                            "enter_store_name");
                      },
                      onEditingComplete: () {
                        node.nextFocus();
                      }),
                  CustomTextField(
                      deviceSize: deviceSize,
                      hint: getTranslated(context, "product_name_ar"),
                      controller: nameArProductController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      icon: AppAssets.userTagIcon,
                      validate: (_) {
                        return AppValidations.validateNotEmptyText(
                            nameArProductController.text,
                            context,
                            "enter_store_name");
                      },
                      onEditingComplete: () {
                        node.nextFocus();
                      }),
                  CustomTextField(
                      deviceSize: deviceSize,
                      hint: getTranslated(context, "product_description"),
                      controller: descriptionProductController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      icon: AppAssets.userTagIcon,
                      validate: (_) {
                        return AppValidations.validateNotEmptyText(
                            descriptionProductController.text,
                            context,
                            "enter_store_name");
                      },
                      onEditingComplete: () {
                        node.nextFocus();
                      }),
                  CustomTextField(
                      deviceSize: deviceSize,
                      hint: getTranslated(context, "qty"),
                      controller: qtyProductController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      icon: AppAssets.userTagIcon,
                      validate: (_) {
                        return AppValidations.validateNotEmptyText(
                            qtyProductController.text, context, "enter_qty");
                      },
                      onEditingComplete: () {
                        node.nextFocus();
                      }),
                  CustomTextField(
                      deviceSize: deviceSize,
                      hint: getTranslated(context, "price"),
                      controller: priceProductController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      icon: AppAssets.userTagIcon,
                      validate: (_) {
                        return AppValidations.validateNotEmptyText(
                            priceProductController.text,
                            context,
                            "enter_price");
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
                              getTranslated(context, "choose_category"),
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
                      items: widget.catCore!.categories!
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
                        print("category id");
                        print(catId);
                      },
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                          // catId = value as int;
                          print("cat id");
                          print(selectedValue);
                          print(catId);
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: deviceSize.width - 100,
                      child: Column(
                        children: [
                          ...List.generate(
                              widget.specCore!.specifications!.length,
                              (index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0,
                                            bottom: 10.0,
                                            left: 10.0),
                                        child: Text(
                                          widget
                                                  .specCore!
                                                  .specifications![index]
                                                  .name ??
                                              "",
                                          style: const TextStyle(
                                              fontFamily:
                                                  AppFonts.cairoFontRegular,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [

                                          ...List.generate(
                                              widget
                                                  .specCore!
                                                  .specifications![index]
                                                  .values!
                                                  .length, (item) {
                                            return SpecialValues(
                                                widget
                                                    .specCore!
                                                    .specifications![index]
                                                    .values![item]
                                                    .value,
                                                widget
                                                    .specCore!
                                                    .specifications![index]
                                                    .values![item]
                                                    .id,
                                                widget
                                                    .specCore!
                                                    .specifications![index]
                                                    .values![item]
                                                    .isSelected,
                                                item,
                                                widget
                                                    .specCore!
                                                    .specifications![index]
                                                    .values);
                                          }),
                                          SizedBox(height: 40),


                                        ],
                                      ),
                                    ],
                                  )),
                          Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              // ElevatedButton(
                              //   child: Text(getTranslated(context, "upload_image"),),
                              //   onPressed: loadAssets,
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              DashedButton(
                                  onPressed: () {
                                    addProductViewModel.pickProductAttachmentFiles();
                                  },
                                  text: getTranslated(context, "upload_image"),
                                  width: deviceSize.width * 0.9),
                              const SizedBox(
                                height: 15,
                              ),
                              if (addProductViewModel.commercialRegisterList.isNotEmpty)
                                for (int i = 0;
                                i < addProductViewModel.commercialRegisterList.length;
                                i++)
                                  FileUploadWidget(
                                    fileuploadType: addProductViewModel
                                        .commercialRegisterListExtensions[i] ==
                                        'pdf'
                                        ? FileUploadType.pdf
                                        : addProductViewModel.commercialRegisterListExtensions[i] == 'jpg'
                                        ? FileUploadType.jpg
                                        : FileUploadType.png,
                                    onPressed: () {
                                      addProductViewModel.commercialRegisterList.removeAt(i);
                                      setState(() {});
                                    },
                                    text: addProductViewModel.commercialRegisterList[i].split('/').last,
                                    width: deviceSize.width * 0.9,
                                  ),


                              SizedBox(
                                  height: deviceSize.height * 0.244,
                                  child: Column(
                                    children: [
                                      // images.isNotEmpty
                                      //     ? Expanded(
                                      //   child: buildGridView(),
                                      // )
                                      //     : Container(),
                                      SizedBox(
                                        height: deviceSize.height * 0.084,
                                        child: Expanded(
                                          flex: 1,
                                          child:
                                          // addProductViewModel.status == Status.loading
                                          //     ? const CircularProgressIndicator(
                                          //   color: AppColors.primary,
                                          // )
                                          //     :
                                          MainButton(
                                              onPressed: () async {
                                               if (_formKey.currentState!.validate()) {
                                                  bool result = await addProductViewModel.spAddProductStore(
                                                      nameProductController.text.toString(),
                                                    nameArProductController.text.toString(),
                                                    descriptionProductController.text.toString(),
                                                    int.parse(priceProductController.text),
                                                    int.parse(qtyProductController.text),
                                                      int.parse(selectedValue!) ,
                                                    selectedIndexes,
                                                      context);
                                                  if (result) {
                                                    toastAppSuccess(
                                                        "Product Added To cart Successfully",
                                                        contest: context);
                                                  } else {
                                                    toastAppErr(
                                                        "Product does not add to Store",
                                                        contest: context);
                                                  }


                                                }
                                              },
                                              text: getTranslated(context, "add_product"),
                                              width: deviceSize.width * 0.9),


                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
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
