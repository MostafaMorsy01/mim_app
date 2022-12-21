import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Products/Views/Mobile/products_list_mobile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'Mobile/search_product_mobile_view.dart';
import 'Mobile/search_store_mobile_view.dart';



class SearchProductView extends StatelessWidget {
  const SearchProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ScreenTypeLayout(
      mobile:  SearchProductMobileView(),
      tablet:  SearchProductMobileView(),
    );
  }
}
