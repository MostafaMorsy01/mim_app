import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Models/city_model.dart';

class LocationButton extends StatefulWidget {
  final String text;
  final double width;
  final Function onPressed;
  final String icon;
  final bool delete;
  final bool border;
  final List<City> selectedCities;

  const LocationButton(
      {Key? key,
      required this.text,
      required this.width,
      required this.onPressed,
      required this.border,
      required this.delete,
      required this.icon,
      required this.selectedCities})
      : super(key: key);

  @override
  State<LocationButton> createState() => _LocationButtonState();
}

class _LocationButtonState extends State<LocationButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPressed();
      },
      child: Container(
        padding: widget.selectedCities.isEmpty
            ? const EdgeInsets.symmetric(vertical: 15, horizontal: 20.0)
            : const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: AppColors.secondary,
          border: Border.all(
              color: widget.border ? AppColors.primary : AppColors.secondary),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ImageIcon(
                  AssetImage(widget.icon),
                  color: AppColors.primary,
                  size: 25,
                ),
                const SizedBox(
                  width: 7.0,
                ),
                Text(
                  widget.text,
                  style: const TextStyle(
                      height: 1.6,
                      color: AppColors.primary,
                      fontFamily: AppFonts.cairoFontBold,
                      fontSize: 18),
                ),
                const Spacer(),
              ],
            ),
            if (widget.selectedCities.isNotEmpty)
              for (int i = 0; i < widget.selectedCities.length; i++)
                Container(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          widget.selectedCities[i].name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              height: 1.6,
                              color: AppColors.primary,
                              fontFamily: AppFonts.cairoFontMedium,
                              fontSize: 20),
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              widget.selectedCities
                                  .remove(widget.selectedCities[i]);
                            });
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
                ),
          ],
        ),
      ),
    );
  }
}
