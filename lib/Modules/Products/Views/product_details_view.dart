import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Products/Views/Mobile/product_details_mobile_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProductsDetailsView extends StatelessWidget {
  static const routeName = '/products_details';
  final int productId;
  final String img;
  const ProductsDetailsView({Key? key, required this.productId, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile:  ProductDetailsMobileView(productId: productId, img:img ,),
      tablet:  ProductDetailsMobileView(productId: productId,img: img,),
    );
  }
}
