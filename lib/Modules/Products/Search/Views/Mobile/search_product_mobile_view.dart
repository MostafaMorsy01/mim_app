import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../Constants/app_colors.dart';
import '../../../../../Constants/app_enums.dart';
import '../../../../../Constants/app_fonts.dart';
import '../../../../../Localization/app_localization.dart';
import '../../../../../Logger/logger.dart';
import '../../../ViewModel/product_view_model.dart';
import '../../../Views/Mobile/products_list_mobile_view.dart';
import '../../../Views/product_details_view.dart';
import '../../../Views/products_list_view.dart';

class SearchProductMobileView extends StatefulWidget {
  const SearchProductMobileView({Key? key}) : super(key: key);

  @override
  State<SearchProductMobileView> createState() => _SearchProductMobileViewState();
}

class _SearchProductMobileViewState extends State<SearchProductMobileView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  late ProductsViewModel productsViewModel;


  @override
  void initState() {
    // TODO: implement initState
    productsViewModel = Provider.of<ProductsViewModel>(context, listen: false);
    // setState(() {
    //   storesCore1 = productsViewModel.storeCoreSearch ;
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    productsViewModel = Provider.of<ProductsViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          padding: EdgeInsets.only(top: 10),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          color: AppColors.white,
          child: SafeArea(
            child: InkWell(
              onTap: () {},
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.primary,
                      size: 32,
                    ),
                    onPressed: () {},
                  ),
                  Spacer(),
                  SizedBox(
                    width: deviceSize.width * 0.75,
                    height: 36,
                    child: TextField(
                      onChanged: (val) async {
                        setState(() {
                          logger.d(searchController.text);
                          Future(() async {
                            print(val);
                            await productsViewModel.searchForProduct(
                                val, context);
                            print("dataaa");
                            print(productsViewModel.storeCoreSearch?.stores);
                          });
                        });
                      },
                      controller: searchController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              searchController.clear();
                            });
                          },
                          icon: Icon(
                            searchController.text.isNotEmpty
                                ? Icons.clear_rounded
                                : null,
                            color: AppColors.searchBarClearRed,
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none),
                        hintText: getTranslated(context, "search"),
                        hintStyle: const TextStyle(
                          fontSize: 17,
                          fontFamily: AppFonts.cairoFontRegular,
                          color: AppColors.searchBarHint,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.searchBarHint,
                        ),
                        filled: true,
                        fillColor: AppColors.searchBarFill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        elevation: 0,
      ),
      body:

      // Container(
      //   child: Column(
      //     children: [
      //       productsViewModel.status1 == Status.loading
      //           ? Center(
      //               child: CircularProgressIndicator(
      //                 color: AppColors.primary,
      //               ),
      //             )
      //           : Expanded(
      //               child: Container(
      //                 margin: const EdgeInsets.symmetric(
      //                     horizontal: 15, vertical: 30),
      //                 child: Center(
      //                   child: Column(
      //                     children: [
      //                       ...List.generate(
      //                           productsViewModel.storeCoreSearch?.stores?.length ?? 0,
      //                           (index) {
      //                             return Text( productsViewModel.storeCoreSearch?.stores?[index].name ?? "mmo");
      //                           })
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             )
      //     ],
      //   ),
      // )

      productsViewModel.status1 == Status.loading ?
      Center(child: CircularProgressIndicator(color: AppColors.primary,),):
      Container(
          child: Column(
            children: [
              Expanded(
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
                                      .productCoreSearch?.products?.length ?? 0,
                                      (index) {
                                    return ProductItemWidget(
                                      img: productsViewModel.productCoreSearch!
                                          .products![index].image ??
                                          "",
                                      name: productsViewModel.productCoreSearch!
                                          .products![index].name ??
                                          "",
                                      price: productsViewModel.productCoreSearch!
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
                                                          .productCoreSearch!
                                                          .products![
                                                      index]
                                                          .id ??
                                                          0,
                                                      img: productsViewModel
                                                          .productCoreSearch!
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
                                                          .productCoreSearch!
                                                          .products![
                                                      index]
                                                          .id ??
                                                          0,
                                                      img: productsViewModel
                                                          .productCoreSearch!
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
          )
      ) ,

    );
  }
}
