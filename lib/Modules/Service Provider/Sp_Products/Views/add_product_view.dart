import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Model/sp_categories_core_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Model/sp_specification_core_model.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'Mobile/add_product_mobile_view.dart';

class AddProductView extends StatelessWidget {
  static const routeName = '/add_product';
  final SpecificationCoreModel? specCore;
  final CategoriesCoreModel? catCore;
  const AddProductView({Key? key, required this.specCore, required this.catCore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile:  AddProductMobileView(specCore: specCore,catCore: catCore,),
      tablet:  AddProductMobileView(specCore: specCore,catCore: catCore,),
    );
  }
}