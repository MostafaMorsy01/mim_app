import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Logger/logger.dart';

class SearchBar extends StatefulWidget {
  const SearchBar(
      {Key? key, required this.searchcontroller, required this.width})
      : super(key: key);

  final TextEditingController searchcontroller;

  final double width;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: 36,
      child: TextField(
        onChanged: (val) async {
          setState(() {
            logger.d(widget.searchcontroller.text);
          });
        },
        controller: widget.searchcontroller,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                widget.searchcontroller.clear();
              });
            },
            icon: Icon(
              widget.searchcontroller.text.isNotEmpty
                  ? Icons.clear_rounded
                  : null,
              color: AppColors.searchBarClearRed,
            ),
          ),
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none),
          hintText: getTranslated(context, "search"),
          hintStyle: const TextStyle(
            fontSize: 17,
            fontFamily: AppFonts.cairoFontRegular,
            color: AppColors.searchBarHint,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.searchBarHint,
          ),
          filled: true,
          fillColor: AppColors.searchBarFill,
        ),
      ),
    );
  }
}
