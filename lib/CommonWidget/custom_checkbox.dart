import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';

// ignore: must_be_immutable
class CustomCheckbox extends StatefulWidget {
  final double width;
  bool checkboxSelected;
  final String text;
  final Function onChanged;
  CustomCheckbox(
      {Key? key,
      this.checkboxSelected = false,
      required this.text,
      required this.width,
      required this.onChanged})
      : super(key: key);

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Row(
        children: [
          Checkbox(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              side: MaterialStateBorderSide.resolveWith(
                (states) =>
                    const BorderSide(width: 1.5, color: AppColors.primary),
              ),
              value: widget.checkboxSelected,
              onChanged: (selected) {
                widget.onChanged(selected);
              }),
          Align(
            alignment: Alignment.centerRight,
            child: SelectableText(
              widget.text,
              style: const TextStyle(
                  fontFamily: AppFonts.cairoFontRegular, fontSize: 17.0),
            ),
          ),
        ],
      ),
    );
  }
}
