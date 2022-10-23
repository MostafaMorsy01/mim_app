import 'package:flutter/material.dart';
import 'package:meem_app/CommonWidget/main_button.dart';
import 'package:meem_app/CommonWidget/quantity_changer.dart';
import 'package:meem_app/CommonWidget/search_appbar.dart';
import 'package:meem_app/Constants/app_assets.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Modules/Cart/ViewModel/add_to_cart_view_model.dart';
import 'package:meem_app/Modules/Products/ViewModel/product_detail_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../CommonWidget/toast.dart';
import '../../../../Constants/app_enums.dart';

class ProductDetailsMobileView extends StatefulWidget {
  final int productId;
  String img;

  ProductDetailsMobileView(
      {Key? key, required this.productId, required this.img})
      : super(key: key);

  @override
  State<ProductDetailsMobileView> createState() =>
      _ProductDetailsMobileViewState();
}

class _ProductDetailsMobileViewState extends State<ProductDetailsMobileView> {
  late ProductsDetailsViewModel productsDetailsViewModel;
  int _counter = 1;
  bool isSelected = false;
  late AddToCartViewModel addToCartViewModel;

  @override
  void initState() {
    addToCartViewModel =
        Provider.of<AddToCartViewModel>(context, listen: false);
    productsDetailsViewModel =
        Provider.of<ProductsDetailsViewModel>(context, listen: false);
    Future(() async {
      await productsDetailsViewModel.ProductsDetailsFetchingData(
          context, widget.productId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productsDetailsViewModel =
        Provider.of<ProductsDetailsViewModel>(context, listen: true);
    addToCartViewModel = Provider.of<AddToCartViewModel>(context, listen: true);
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: const SearchAppBar(),
        elevation: 0,
      ),
      body: productsDetailsViewModel.secondaryStatus == Status.loading ||
              productsDetailsViewModel.productDetailsCore == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    alignment: setAlignmnetToCenterStart(context),
                    child: SelectableText(
                      productsDetailsViewModel
                              .productDetailsCore!.product!.name ??
                          "",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: AppFonts.cairoFontSemiBold, fontSize: 18),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child:
                            // Image.network(
                            //   AppAssets.testShoes,
                            // ),
                            Image.network(
                          "http://164.92.185.162/public/" + widget.img,
                          width: deviceSize.width - 50,
                          height: deviceSize.height / 4,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 25,
                        child: IconButton(
                          icon: const ImageIcon(
                            AssetImage(AppAssets.favRedOutlined),
                            color: AppColors.favRed,
                            size: 28,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 28, 20, 14),
                    alignment: setAlignmnetToCenterStart(context),
                    child: SelectableText(
                      getTranslated(context, "product_images"),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontFamily: AppFonts.cairoFontSemiBold,
                          fontSize: 15,
                          color: AppColors.grey162),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: setAlignmnetToCenterStart(context),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                            productsDetailsViewModel
                                .productDetailsCore!.product!.images!.length,
                            (index) => ProductImagesWidget(
                              selected: isSelected,
                              onPressed: () {
                                setState(() {
                                  isSelected = true;
                                  print(isSelected);
                                  widget.img = productsDetailsViewModel
                                          .productDetailsCore!
                                          .product!
                                          .images![index]
                                          .path ??
                                      "";
                                  print(widget.img);
                                });
                              },
                              img: productsDetailsViewModel.productDetailsCore!
                                      .product!.images![index].path ??
                                  "",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 28, 20, 12),
                    alignment: setAlignmnetToCenterStart(context),
                    child: SelectableText(
                      getTranslated(context, "store"),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontFamily: AppFonts.cairoFontSemiBold,
                          fontSize: 15,
                          height: 0.8,
                          color: AppColors.grey162),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: setAlignmnetToCenterStart(context),
                    child: SelectableText(
                      productsDetailsViewModel
                              .productDetailsCore!.product!.store ??
                          "",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: AppFonts.cairoFontSemiBold,
                          fontSize: 18,
                          color: AppColors.black),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 28, 20, 12),
                    alignment: setAlignmnetToCenterStart(context),
                    child: SelectableText(
                      getTranslated(context, "product_description"),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontFamily: AppFonts.cairoFontSemiBold,
                          fontSize: 15,
                          height: 0.8,
                          color: AppColors.grey162),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: setAlignmnetToCenterStart(context),
                    child: SelectableText(
                      productsDetailsViewModel
                              .productDetailsCore!.product!.description ??
                          "",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: AppFonts.cairoFontSemiBold,
                          height: 1.35,
                          fontSize: 18,
                          color: AppColors.black),
                    ),
                  ),
                  Container(
                    alignment: setAlignmnetToCenterStart(context),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Text(
                      " ${productsDetailsViewModel.productDetailsCore!.product!.price ?? 0.0}  ر.س ",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: AppFonts.cairoFontBold, fontSize: 20),
                    ),
                  ),

                  /// Product Qty
                  // Container(
                  //   width: deviceSize.width,
                  //   margin: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: Row(
                  //     children: [
                  //       Container(
                  //         alignment: setAlignmnetToCenterStart(context),
                  //         child: SelectableText(
                  //           getTranslated(context, "quantity"),
                  //           textAlign: TextAlign.start,
                  //           style: const TextStyle(
                  //               fontFamily: AppFonts.cairoFontSemiBold,
                  //               fontSize: 15,
                  //               height: 0.8,
                  //               color: AppColors.grey162),
                  //         ),
                  //       ),
                  //
                  //       // const Spacer(),
                  //       //  SizedBox(
                  //       //   width: 160,
                  //       //   child: Row(
                  //       //     mainAxisAlignment: MainAxisAlignment.center,
                  //       //     children: [
                  //       //       const Spacer(),
                  //       //       Container(
                  //       //
                  //       //         // decoration: BoxDecoration(
                  //       //         //     border: Border.all(
                  //       //         //       color: AppColors.primary,
                  //       //         //       width: 2.5,
                  //       //         //     ),
                  //       //         //     borderRadius: BorderRadius.circular(5)),
                  //       //         child: IconButton(
                  //       //           color: AppColors.primary,
                  //       //           icon: Icon(
                  //       //             Icons.add,
                  //       //             size: 26,
                  //       //           ),
                  //       //           onPressed: () {
                  //       //             setState(() {
                  //       //               if (_counter != 5)
                  //       //               {
                  //       //                 _counter++;
                  //       //               }
                  //       //
                  //       //             });
                  //       //           },
                  //       //         ),
                  //       //       ),
                  //       //       const Spacer(),
                  //       //       Text(
                  //       //         "$_counter",
                  //       //         style: TextStyle(
                  //       //           color: AppColors.black,
                  //       //           fontFamily: AppFonts.cairoFontSemiBold,
                  //       //           fontSize: 20,
                  //       //         ),
                  //       //       ),
                  //       //       const Spacer(),
                  //       //       Container(
                  //       //         // decoration: BoxDecoration(
                  //       //         //     border: Border.all(
                  //       //         //       color: AppColors.primary,
                  //       //         //       width: 2.5,
                  //       //         //     ),
                  //       //         //     borderRadius: BorderRadius.circular(5)),
                  //       //         child: IconButton(
                  //       //           color: AppColors.primary,
                  //       //           icon: Icon(
                  //       //             Icons.remove,
                  //       //             size: 26,
                  //       //           ),
                  //       //           onPressed: () {
                  //       //             setState(() {
                  //       //               if(_counter != 1){
                  //       //                 _counter--;
                  //       //               }
                  //       //
                  //       //             });
                  //       //           },
                  //       //         ),
                  //       //       ),
                  //       //       const Spacer(),
                  //       //     ],
                  //       //   ),
                  //       // ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  addToCartViewModel.status == Status.loading
                      ? const Center(child: CircularProgressIndicator())
                      : MainButton(
                          text: getTranslated(context, "go_to_cart"),
                          width: deviceSize.width - 40,
                          onPressed: () async {
                            bool result = await addToCartViewModel.addToCart(
                                widget.productId, context);

                            if (result) {
                              toastAppSuccess(
                                  "Product Added To cart Successfully",
                                  contest: context);
                            } else {
                              toastAppErr("Product does not add to cart",
                                  contest: context);
                            }
                          }),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
    );
  }
}

class ProductImagesWidget extends StatelessWidget {
  const ProductImagesWidget({
    Key? key,
    required this.selected,
    required this.onPressed,
    required this.img,
  }) : super(key: key);
  final String img;
  final bool selected;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border:
              selected ? Border.all(color: AppColors.primary, width: 2) : null,
          image: DecorationImage(
            image: NetworkImage("http://164.92.185.162/public/" + img),
          ),
        ),
      ),
    );
  }
}
