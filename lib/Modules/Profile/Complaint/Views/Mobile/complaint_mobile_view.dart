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
import '../../../../Service Provider/Authentication/Views/Mobile/signup_mobile_view.dart';
import '../../ViewModel/complaint_view_model.dart';


class ComplaintMobileView extends StatefulWidget {


  const ComplaintMobileView(
      {Key? key,})
      : super(key: key);

  @override
  State<ComplaintMobileView> createState() => _ComplaintMobileViewState();
}

class _ComplaintMobileViewState extends State<ComplaintMobileView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obsecureText = true;
  bool checkboxSelected = true;
  bool verifiedAccountSelected = false;
  String? selectedValue;
  String? selectedSize = "";
  int? catId;
  List<int> selectedIndexes = [];
  List<int> _selectedValues = [];
  late ComplaintViewModel complaintViewModel;


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
        complaintViewModel.imagesList.addAll(images);
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
    nameController.dispose();
    emailController.dispose();
    contentController.dispose();
    controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    // _selectedValues = widget.specCore.specifications
    complaintViewModel =
        Provider.of<ComplaintViewModel>(context, listen: false);
    selectedIndexes = _selectedValues;


    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    complaintViewModel =
        Provider.of<ComplaintViewModel>(context, listen: true);
    final deviceSize = MediaQuery.of(context).size;


    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: TitleAppBar(
          title: getTranslated(context, "complaint"),
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
                      controller: nameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      icon: AppAssets.userTagIcon,
                      validate: (_) {
                        return AppValidations.validateNotEmptyText(
                            nameController.text,
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
                      textInputAction: TextInputAction.next,
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
                      hint: getTranslated(context, "content"),
                      controller: contentController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      icon: AppAssets.userTagIcon,
                      validate: (_) {
                        return AppValidations.validateNotEmptyText(
                            contentController.text,
                            context,
                            "enter_content");
                      },
                      onEditingComplete: () {
                        node.nextFocus();
                      }),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: deviceSize.width - 100,
                      child: Column(
                        children: [

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
                                    complaintViewModel.pickProductAttachmentFiles();
                                  },
                                  text: getTranslated(context, "complaint_attach"),
                                  width: deviceSize.width * 0.9),
                              const SizedBox(
                                height: 15,
                              ),
                              if (complaintViewModel.commercialRegisterList.isNotEmpty)
                                for (int i = 0;
                                i < complaintViewModel.commercialRegisterList.length;
                                i++)
                                  FileUploadWidget(
                                    fileuploadType: complaintViewModel
                                        .commercialRegisterListExtensions[i] ==
                                        'pdf'
                                        ? FileUploadType.pdf
                                        : complaintViewModel.commercialRegisterListExtensions[i] == 'jpg'
                                        ? FileUploadType.jpg
                                        : FileUploadType.png,
                                    onPressed: () {
                                      complaintViewModel.commercialRegisterList.removeAt(i);
                                      setState(() {});
                                    },
                                    text: complaintViewModel.commercialRegisterList[i].split('/').last,
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
                                        child: MainButton(
                                            onPressed: () async {
                                              if (_formKey.currentState!.validate()) {
                                                bool result = await complaintViewModel.spAddProductStore(
                                                    nameController.text.toString(),
                                                    emailController.text.toString(),
                                                    contentController.text.toString(),

                                                    context);
                                                if (result) {
                                                  toastAppSuccess(
                                                      "Complaint Added Successfully",
                                                      contest: context);
                                                } else {
                                                  toastAppErr(
                                                      "Complaint does not add ",
                                                      contest: context);
                                                }


                                              }
                                            },
                                            text: getTranslated(context, "complaint"),
                                            width: deviceSize.width * 0.9),
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
