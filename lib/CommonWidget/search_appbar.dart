import 'package:flutter/material.dart';
import 'package:meem_app/CommonWidget/search_bar.dart';
import 'package:meem_app/Constants/app_colors.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({Key? key}) : super(key: key);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {


  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      color: AppColors.white,
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.primary,
                size: 32,
              ),
              onPressed: () {},
            ),
            const Spacer(),
            SearchBar(
              searchcontroller: TextEditingController(),
              width: deviceSize.width * 0.75,
            ),
          ],
        ),
      ),
    );
  }
}
