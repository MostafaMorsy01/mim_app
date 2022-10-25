import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'Mobile/favourite_list_mobile_view.dart';

class ListFavouriteView extends StatelessWidget {
  const ListFavouriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: ListFavouriteMobileView(),
      tablet: ListFavouriteMobileView(),
    );
  }
}
