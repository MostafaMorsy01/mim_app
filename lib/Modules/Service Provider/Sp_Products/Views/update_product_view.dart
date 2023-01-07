import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Model/sp_categories_core_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Model/sp_specification_core_model.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'Mobile/add_product_mobile_view.dart';
import 'Mobile/update_product_mobile_view.dart';

class UpdateProductView extends StatelessWidget {
  static const routeName = '/add_product';
  final SpecificationCoreModel? specCore;
  final CategoriesCoreModel? catCore;
  final int? product_id;
  const UpdateProductView({Key? key, required this.specCore, required this.catCore,required this.product_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile:  UpdateProductMobileView(specCore: specCore,catCore: catCore,product_id: product_id,),
      tablet:  UpdateProductMobileView(specCore: specCore,catCore: catCore,product_id: product_id,),
    );
  }
}