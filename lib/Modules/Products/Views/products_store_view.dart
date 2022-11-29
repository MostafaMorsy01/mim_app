import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Products/Views/Mobile/products_list_mobile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../Models/HomeModel/HomeFeaturedCategoryModel.dart';
import '../../../Models/HomeModel/store_model.dart';
import 'Mobile/products_store_mobile_view.dart';

class ProductsStoreListView extends StatelessWidget {
  static const routeName = '/products_list';
  final List<StoresModel>?  storesCore;

  const ProductsStoreListView({Key? key, required this.storesCore}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ScreenTypeLayout(
      mobile:  ProductStoreMobileView(storesCore: storesCore,),
      tablet:  ProductStoreMobileView(storesCore: storesCore,),
    );
  }
}
