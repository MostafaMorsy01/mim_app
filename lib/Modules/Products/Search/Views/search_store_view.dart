import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Products/Views/Mobile/products_list_mobile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../Models/HomeModel/store_model.dart';
import 'Mobile/search_store_mobile_view.dart';



class SearchStoreView extends StatelessWidget {
  const SearchStoreView({Key? key, required this.storesCore}) : super(key: key);
  final List<StoresModel>?  storesCore;

  @override
  Widget build(BuildContext context) {

    return ScreenTypeLayout(
      mobile:  SearchStoreMobileView(storesCore: storesCore,),
      tablet:  SearchStoreMobileView(storesCore: storesCore,),
    );
  }
}
