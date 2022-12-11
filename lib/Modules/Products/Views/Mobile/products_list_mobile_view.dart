import 'dart:math';
import 'package:flutter/material.dart';
import 'package:meem_app/CommonWidget/add_to_cart_button.dart';
import 'package:meem_app/CommonWidget/quantity_changer.dart';
import 'package:meem_app/CommonWidget/search_appbar.dart';
import 'package:meem_app/Constants/app_assets.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Modules/Products/Views/product_details_view.dart';
import 'package:provider/provider.dart';

import '../../../../CommonWidget/toast.dart';
import '../../../../Constants/app_enums.dart';
import '../../../Cart/ViewModel/add_to_cart_view_model.dart';
import '../../ViewModel/product_view_model.dart';

class ProductsListMobileView extends StatefulWidget {
  final int productId;
  final String storeName;

  const ProductsListMobileView(
      {Key? key, required this.productId, required this.storeName})
      : super(key: key);

  @override
  State<ProductsListMobileView> createState() => _ProductsListMobileViewState();
}

class _ProductsListMobileViewState extends State<ProductsListMobileView> {
  final ScrollController _scrollController = ScrollController();
  late ProductsViewModel productsViewModel;
  late AddToCartViewModel addToCartViewModel;

  @override
  void initState() {
    addToCartViewModel =
        Provider.of<AddToCartViewModel>(context, listen: false);
    productsViewModel = Provider.of<ProductsViewModel>(context, listen: false);
    Future(() async {
      await productsViewModel.ProductsFetchingData(context, widget.productId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    productsViewModel = Provider.of<ProductsViewModel>(context, listen: true);
    addToCartViewModel = Provider.of<AddToCartViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: const SearchAppBar(),
        elevation: 0,
      ),
      body: productsViewModel.secondaryStatus == Status.loading ||
              productsViewModel.productCore == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Row(
                    children: [
                      SelectableText(
                        '${getTranslated(context, "products")} ${widget.storeName}',
                        style: const TextStyle(
                            fontFamily: AppFonts.cairoFontSemiBold,
                            fontSize: 18),
                      ),
                      const Spacer(),

                    ],
                  ),
                ),
                addToCartViewModel.status == Status.loading
                    ? const Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (scrollNotification) {
                            // if (scrollNotification.metrics.pixels ==
                            //         scrollNotification.metrics.maxScrollExtent &&
                            //     vendorsViewModel!.status != Status.loading) {
                            //   vendorsView§Model!.fetchVendorsByCategoryID(
                            //       context,
                            //       widget.id,
                            //       authenticationViewModel!.accessToken!,
                            //       searchcontroller.text);

                            //   return true;
                            // } else {
                            //   return false;
                            // }
                            return false;
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: Center(
                                child: Scrollbar(
                              controller: _scrollController,
                              child: CustomScrollView(
                                controller: _scrollController,
                                scrollDirection: Axis.vertical,
                                physics: const AlwaysScrollableScrollPhysics(),
                                slivers: <Widget>[
                                  SliverGrid.count(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 10.0,
                                    childAspectRatio:
                                        ((deviceSize.width * 0.5 - 25) / 336),
                                    children: List.generate(
                                      productsViewModel
                                          .productCore!.products!.length,
                                      (index) {
                                        return ProductItemWidget(
                                          img: productsViewModel.productCore!
                                                  .products![index].image ??
                                              "",
                                          name: productsViewModel.productCore!
                                                  .products![index].name ??
                                              "",
                                          price: productsViewModel.productCore!
                                                  .products![index].price ??
                                              0,
                                          onPressedAddToCart: () async {
                                            // bool result =
                                            //     await addToCartViewModel
                                            //         .addToCart(productsViewModel.productCore!
                                            //         .products![index].id ??
                                            //         0,
                                            //             context);
                                            //
                                            // if (result) {
                                            //   toastAppSuccess(
                                            //       "Product Added To cart Successfully",
                                            //       contest: context);
                                            // } else {
                                            //   toastAppErr(
                                            //       "Product does not add to cart",
                                            //       contest: context);
                                            // }
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductsDetailsView(
                                                          productId:
                                                          productsViewModel
                                                              .productCore!
                                                              .products![
                                                          index]
                                                              .id ??
                                                              0,
                                                          img: productsViewModel
                                                              .productCore!
                                                              .products![
                                                          index]
                                                              .image ??
                                                              "",
                                                        )));
                                          },
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductsDetailsView(
                                                          productId:
                                                              productsViewModel
                                                                      .productCore!
                                                                      .products![
                                                                          index]
                                                                      .id ??
                                                                  0,
                                                          img: productsViewModel
                                                                  .productCore!
                                                                  .products![
                                                                      index]
                                                                  .image ??
                                                              "",
                                                        )));
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
              ],
            ),
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    Key? key,
    required this.img,
    required this.name,
    required this.price,
    required this.onPressed,
    required this.onPressedAddToCart,
  }) : super(key: key);

  final String img;
  final String name;
  final int price;
  final Function onPressed;
  final Function onPressedAddToCart;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.grey217,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                onPressed();
              },
              child: Column(
                children: [Container(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //     image: AssetImage(img),
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  child: Image.network(
                    img,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  //  child: CachedNetworkImage(
                  //     imageUrl: "h",
                  //     errorWidget: (context, url, _) => Container(
                  //       decoration: BoxDecoration(
                  //         image: DecorationImage(
                  //           image: AssetImage(img),
                  //           fit: BoxFit.cover,
                  //         ),
                  //       ),
                  //     ),
                  //     placeholder: (context, url) => Container(
                  //       decoration: BoxDecoration(
                  //         image: DecorationImage(
                  //           image: AssetImage(img),
                  //           fit: BoxFit.cover,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      name,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: AppFonts.cairoFontSemiBold, fontSize: 15),
                    ),
                  ),
                  Container(
                    alignment: setAlignmnetToCenterStart(context),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "${price} ر.س ",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: AppFonts.cairoFontBold, fontSize: 18),
                    ),
                  ),],
              ),
            ),
            const Spacer(),
            AddToCartButton(onPressed: (){
              onPressedAddToCart();
            })
            // Random().nextDouble() <= 0.7
            //     ? AddToCartButton(onPressed: onPressed)
            //     : const QuantityChanger(),
            //AddToCartButton(onPressed: () {})
          ],
        ),
      ),
    );
  }
}
