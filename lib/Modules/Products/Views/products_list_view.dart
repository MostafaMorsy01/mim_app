import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Products/Views/Mobile/products_list_mobile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProductsListView extends StatelessWidget {
  static const routeName = '/products_list';
  final int productId;
  final String storeName;
  const ProductsListView({Key? key, required this.productId, required this.storeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ScreenTypeLayout(
      mobile:  ProductsListMobileView(
        productId: productId,
        storeName: storeName,

      ),
      tablet:  ProductsListMobileView(
        productId: productId,
        storeName: storeName,

      ),
    );
  }
}
