import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../CommonWidget/title_appbar.dart';
import '../../../../CommonWidget/toast.dart';
import '../../../../Constants/app_assets.dart';
import '../../../../Constants/app_colors.dart';
import '../../../../Constants/app_enums.dart';
import '../../../../Constants/app_fonts.dart';
import '../../../../Localization/app_localization.dart';
import '../../../Cart/ViewModel/add_to_cart_view_model.dart';
import '../../../Products/Views/Mobile/products_list_mobile_view.dart';
import '../../../Products/Views/product_details_view.dart';
import '../../ViewModel/list_favourite_view_model.dart';

class ListFavouriteMobileView extends StatefulWidget {
  const ListFavouriteMobileView({Key? key}) : super(key: key);
  static String id = 'favouriteScreen';

  @override
  State<ListFavouriteMobileView> createState() =>
      _ListFavouriteMobileViewState();
}

class _ListFavouriteMobileViewState extends State<ListFavouriteMobileView> {
  final ScrollController _scrollController = ScrollController();
  late ListFavouriteViewModel listFavouriteViewModel;
  late AddToCartViewModel addToCartViewModel;

  bool isVisible1 = false;

  @override
  void initState() {
    listFavouriteViewModel =
        Provider.of<ListFavouriteViewModel>(context, listen: false);
    Future(() async {
      await listFavouriteViewModel.FavouriteFetchingData(context);
    });
    callThisMethod(isVisible1);
    super.initState();
  }

  void callThisMethod(bool isVisible) {
    debugPrint('_FavouriteScreen.callThisMethod: isVisible: ${isVisible}');
    if (isVisible) {
      listFavouriteViewModel.FavouriteFetchingData(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    listFavouriteViewModel =
        Provider.of<ListFavouriteViewModel>(context, listen: true);
    addToCartViewModel = Provider.of<AddToCartViewModel>(context, listen: true);
    return VisibilityDetector(
      key: Key(ListFavouriteMobileView.id),
      onVisibilityChanged: (VisibilityInfo info) {
        bool isVisible = info.visibleFraction != 0;
        callThisMethod(isVisible);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: TitleAppBar(
            title: getTranslated(context, "favorites"),
          ),
          elevation: 0,
        ),
        body: listFavouriteViewModel.secondaryStatus == Status.loading ||
                listFavouriteViewModel.favCore == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   child: Text(
                  //       "${listFavouriteViewModel.favCore!.products!.length}"),
                  // ),
                  addToCartViewModel.status == Status.loading
                      ? const Center(child: CircularProgressIndicator())
                      : Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  height: deviceSize.height * 0.7,
                                  child: GridView.builder(
                                      itemCount: listFavouriteViewModel.favCore!.products!.length,
                                      scrollDirection: Axis.vertical,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 100 / 186,
                                        crossAxisCount: 2,
                                      ),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:  ProductItemWidget(
                                        img: listFavouriteViewModel
                                            .favCore!
                                            .products![index]
                                          .image ??
                                          "",
                                          name: listFavouriteViewModel
                                              .favCore!
                                              .products![index]
                                              .name ??
                                              "",
                                          price: listFavouriteViewModel
                                              .favCore!
                                              .products![index]
                                              .price ??
                                              0,
                                          onPressedAddToCart: () async {
                                            // bool result =
                                            // await addToCartViewModel
                                            //     .addToCart(
                                            //     listFavouriteViewModel
                                            //         .favCore!
                                            //         .products![
                                            //     index]
                                            //         .id ??
                                            //         0,
                                            //     context);
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
                                                          listFavouriteViewModel
                                                              .favCore!
                                                              .products![
                                                          index]
                                                              .id ??
                                                              0,
                                                          img: listFavouriteViewModel
                                                              .favCore!
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
                                                          listFavouriteViewModel
                                                              .favCore!
                                                              .products![
                                                          index]
                                                              .id ??
                                                              0,
                                                          img: listFavouriteViewModel
                                                              .favCore!
                                                              .products![
                                                          index]
                                                              .image ??
                                                              "",
                                                        )));
                                          },
                                        )
                                        );
                                      }),
                                ),
                                // GridView.builder(
                                //   shrinkWrap: true,
                                //   itemCount: listFavouriteViewModel.favCore?.products?.length,
                                //   itemBuilder: (context, index) {
                                //     return  Container(
                                //       height: 200,
                                //       color: Colors.blue,
                                //     );
                                //   }, gridDelegate: null,
                                // ),
                              ],
                            ),

                            // [Text("data")]
                            // List.generate(
                            //   listFavouriteViewModel
                            //       .productCore!.products!.length,
                            //   (index) {
                            //     return ProductItemWidget(
                            //       img: listFavouriteViewModel
                            //               .productCore!
                            //               .products![index]
                            //               .image ??
                            //           "",
                            //       name: listFavouriteViewModel
                            //               .productCore!
                            //               .products![index]
                            //               .name ??
                            //           "",
                            //       price: listFavouriteViewModel
                            //               .productCore!
                            //               .products![index]
                            //               .price ??
                            //           0,
                            //       onPressedAddToCart: () async {
                            //         bool result =
                            //             await addToCartViewModel
                            //                 .addToCart(
                            //                     listFavouriteViewModel
                            //                             .productCore!
                            //                             .products![
                            //                                 index]
                            //                             .id ??
                            //                         0,
                            //                     context);
                            //
                            //         if (result) {
                            //           toastAppSuccess(
                            //               "Product Added To cart Successfully",
                            //               contest: context);
                            //         } else {
                            //           toastAppErr(
                            //               "Product does not add to cart",
                            //               contest: context);
                            //         }
                            //       },
                            //       onPressed: () {
                            //         Navigator.push(
                            //             context,
                            //             MaterialPageRoute(
                            //                 builder: (context) =>
                            //                     ProductsDetailsView(
                            //                       productId:
                            //                           listFavouriteViewModel
                            //                                   .productCore!
                            //                                   .products![
                            //                                       index]
                            //                                   .id ??
                            //                               0,
                            //                       img: listFavouriteViewModel
                            //                               .productCore!
                            //                               .products![
                            //                                   index]
                            //                               .image ??
                            //                           "",
                            //                     )));
                            //       },
                            //     );
                            //   },
                            // ),
                          ),
                        ),
                ],
              ),
      ),
    );
  }
}
