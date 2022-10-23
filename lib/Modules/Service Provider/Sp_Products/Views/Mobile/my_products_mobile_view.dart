import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meem_app/CommonWidget/title_appbar.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/ViewModel/categories_view_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/ViewModel/sp_my_products_view_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/ViewModel/specification_view_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Views/add_product_view.dart';
import 'package:provider/provider.dart';

import '../../../../../Constants/app_enums.dart';
import '../../Model/specification_model.dart';

class SpMyProductsMobileView extends StatefulWidget {
  const SpMyProductsMobileView({Key? key}) : super(key: key);

  @override
  State<SpMyProductsMobileView> createState() => _SpMyProductsMobileViewState();
}

class _SpMyProductsMobileViewState extends State<SpMyProductsMobileView> {
  final ScrollController _scrollController = ScrollController();
  late SpProductsViewModel sp_productsViewModel;
  late SpecificationViewModel specificationViewModel;
  late CategoriesViewModel categoriesViewModel;

  List<Values> values = [];

  @override
  void initState() {
    sp_productsViewModel =
        Provider.of<SpProductsViewModel>(context, listen: false);
    specificationViewModel =
        Provider.of<SpecificationViewModel>(context, listen: false);
    categoriesViewModel =
        Provider.of<CategoriesViewModel>(context, listen: false);
    Future(() async {
      await sp_productsViewModel.spProductsFetchingData(context);
      await specificationViewModel.specificationFetchingData(context);
      await categoriesViewModel.categoriesFetchingData(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    sp_productsViewModel =
        Provider.of<SpProductsViewModel>(context, listen: true);
    specificationViewModel =
        Provider.of<SpecificationViewModel>(context, listen: true);
    categoriesViewModel =
        Provider.of<CategoriesViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: TitleAppBar(
          title: getTranslated(context, "my_products"),
          buttonTitle: getTranslated(context, "new_product"),
          onPrssed: (){
            print("pressed");
            print(AddProductView.routeName);
            // Navigator.of(context).pushNamed(AddProductView.routeName);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddProductView(specCore: specificationViewModel.specificationCore!, catCore: categoriesViewModel.catCore!)
                        ));


          },
        ),
        elevation: 0,
      ),
      body: SizedBox(
          height: deviceSize.height,
          child: sp_productsViewModel.secondaryStatus == Status.loading ||
                  sp_productsViewModel.spCore == null || categoriesViewModel.catCore == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount:
                            sp_productsViewModel.spCore!.spProducts!.length,
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 20, top: 20),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "http://164.92.185.162/public/" +
                                                    sp_productsViewModel
                                                        .spCore!
                                                        .spProducts![index]
                                                        .image!),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      Container(
                                        height: 100,
                                        width: deviceSize.width * 0.6,

                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 8.0),
                                                  child: Text(sp_productsViewModel
                                                      .spCore!
                                                      .spProducts![index]
                                                      .description!,style: const TextStyle(
                                                      fontFamily: AppFonts.cairoFontRegular,
                                                      fontSize: 18.0),),
                                                ),
                                                SvgPicture.asset(
                                                  "assets/images/edit.svg",
                                                  width: 20,
                                                  height: 20,
                                                )
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 8.0),
                                                  child: Text(sp_productsViewModel
                                                      .spCore!
                                                      .spProducts![index]
                                                      .name!,style: const TextStyle(
                                                      fontFamily: AppFonts.cairoFontRegular,
                                                      fontSize: 18.0),),
                                                ),
                                                SvgPicture.asset(
                                                  "assets/images/trash.svg",
                                                  width: 20,
                                                  height: 20,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                  ],
                )),
    );
  }
}

// class PaymentOptionWidget extends StatefulWidget {
//   final String name;
//   final String image;
//   final Function onSelected;
//   const PaymentOptionWidget({
//     Key? key,
//     required this.name,
//     required this.image,
//     required this.onSelected,
//   }) : super(key: key);
//
//   @override
//   State<PaymentOptionWidget> createState() => _PaymentOptionWidgetState();
// }
//
// class _PaymentOptionWidgetState extends State<PaymentOptionWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final deviceSize = MediaQuery.of(context).size;
//     double width = (deviceSize.width * 0.9 * 0.25) - 10;
//     return Container(
//       padding: EdgeInsets.symmetric(
//           horizontal: deviceSize.width * 0.05, vertical: 5.0),
//       child: Row(
//         children: [
//           Checkbox(
//               shape: RoundedRectangleBorder(
//                 borderRadius: const BorderRadius.all(Radius.circular(5.0)),
//                 side: MaterialStateBorderSide.resolveWith(
//                   (states) =>
//                       const BorderSide(width: 1.0, color: AppColors.primary),
//                 ),
//               ),
//               value: true,
//               onChanged: (_) {
//                 setState(() {
//                   // widget.checkboxSelected = !widget.checkboxSelected;
//                 });
//               }),
//           const SizedBox(
//             width: 5.0,
//           ),
//           Container(
//             width: width,
//             height: width * 0.65,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(13),
//               color: AppColors.white,
//               border: Border.all(color: AppColors.grey208),
//             ),
//             child: Image.asset(
//               widget.image,
//             ),
//           ),
//           const SizedBox(
//             width: 5.0,
//           ),
//           Align(
//             alignment: Alignment.centerRight,
//             child: SelectableText(
//               widget.name,
//               style: const TextStyle(
//                   fontFamily: AppFonts.cairoFontMedium, fontSize: 18.0),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
