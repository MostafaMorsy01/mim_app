import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';

class SelectableCircleWidget extends StatefulWidget {
  final Size deviceSize;
  final Function onPressed;
  final String title;
  final bool isSelected;
  const SelectableCircleWidget(
      {Key? key,
      required this.deviceSize,
      required this.onPressed,
      required this.title,
      required this.isSelected})
      : super(key: key);

  @override
  State<SelectableCircleWidget> createState() => _SelectableCircleWidgetState();
}

class _SelectableCircleWidgetState extends State<SelectableCircleWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.deviceSize.width * 0.9,
      child: GestureDetector(
        onTap: () {
          widget.onPressed();
        },
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.isSelected ? AppColors.blue1 : AppColors.white,
                border: Border.all(color: AppColors.blue1, width: 2.0),
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
                widget.title,
                style: const TextStyle(
                    fontFamily: AppFonts.cairoFontRegular, fontSize: 17.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
