import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Localization/app_localization.dart';

import '../Constants/app_fonts.dart';

class CustomDropDown extends StatefulWidget {
  final TextEditingController controller;
  final String? icon;
  final String hint;
  final List items;

  const CustomDropDown(
      {Key? key,
      required this.controller,
      required this.items,
      required this.hint,
      this.icon})
      : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
      // width: deviceSize.width * 0.7,
      child: Column(
        children: [
          // if (Platform.isAndroid)
          //   SizedBox(
          //     width: deviceSize.width * 0.8,
          //     child: DropdownButtonFormField(
          //       value: countryValue,
          //       dropdownColor: ConstantColors.backGroundColor,
          //       iconEnabledColor: ConstantColors.primaryBlue,
          //       validator: (s) {
          //         return userDataViewModel!
          //             .validateCountry(countryValue, context);
          //       },
          //       items: countries
          //           .map(
          //             (label) => DropdownMenuItem(
          //               child: Text(
          //                 getTranslated(context, label),
          //               ),
          //               value: label.toString(),
          //             ),
          //           )
          //           .toList(),
          //       onChanged: (value) {
          //         setState(() {
          //           countryValue = value.toString();
          //           cityValue = cities[value.toString()]![0];
          //           countryController.text = value.toString();
          //         });
          //       },
          //       style: const TextStyle(
          //         color: Colors.black,
          //         fontFamily: "Aeonik",
          //         fontSize: 18.0,
          //         fontWeight: FontWeight.w600,
          //         height: 1,
          //       ),
          //       decoration: InputDecoration(
          //         filled: true,
          //         fillColor: ConstantColors.primaryBlue.withOpacity(0.2),
          //         border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(5.0),
          //         ),
          //         enabledBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(5.0),
          //         ),
          //         focusedBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(5.0),
          //         ),
          //         contentPadding: const EdgeInsets.symmetric(
          //           vertical: 1.0,
          //           horizontal: 10.0,
          //         ),
          //       ),
          //     ),
          //   ),
          if (Platform.isIOS)
            SizedBox(
              height: deviceSize.height * 0.1,
              width: deviceSize.width * 0.85,
              child: TextFormField(
                readOnly: true,
                controller: widget.controller,
                maxLines: 1,
                obscureText: false,
                validator: (_) {
                  return getTranslated(context, "please_select_item");
                },
                onEditingComplete: () {},
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: AppFonts.cairoFontRegular,
                  fontSize: deviceSize.height > 900
                      ? 28
                      : (deviceSize.height > 450 ? 18 : 18),
                ),
                decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: const TextStyle(
                      color: AppColors.black,
                      fontFamily: AppFonts.cairoFontRegular,
                      fontSize: 17.0),
                  errorStyle: const TextStyle(
                    fontSize: 14.0,
                  ),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primary,
                    ),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primary,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primary,
                    ),
                  ),
                  prefixIcon: widget.icon != ""
                      ? ImageIcon(
                          AssetImage(widget.icon!),
                          color: AppColors.textFieldIcon,
                          size: 25,
                        )
                      : null,
                ),
                cursorColor: Colors.black,
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (_) => Container(
                      color: Colors.white,
                      height: deviceSize.height * 0.3,
                      child: Column(
                        children: [
                          Container(
                            height: deviceSize.height * 0.1,
                            alignment: Alignment.centerRight,
                            child: CupertinoButton(
                              child: Text(
                                getTranslated(context, "done"),
                                style: const TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          SizedBox(
                            width: deviceSize.width,
                            height: deviceSize.height * 0.2,
                            child: CupertinoPicker(
                              backgroundColor: AppColors.white,
                              itemExtent: 30,
                              scrollController: FixedExtentScrollController(
                                initialItem: 0,
                              ),
                              children: widget.items
                                  .map(
                                    (label) => Text(
                                      label.name,
                                    ),
                                  )
                                  .toList(),
                              onSelectedItemChanged: (value) {
                                setState(() {
                                  // countryValue = countries[value];
                                  // cityValue = cities[countryValue]![0];
                                  // countryController.text =
                                  //     getTranslated(context, countries[value]);
                                  // cityController.text = cityValue;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
