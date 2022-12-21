import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../Constants/app_colors.dart';
import '../../../../../Constants/app_enums.dart';
import '../../../../../Constants/app_fonts.dart';
import '../../../../../Localization/app_localization.dart';
import '../../../../../Logger/logger.dart';
import '../../../../../Models/HomeModel/store_model.dart';
import '../../../ViewModel/product_view_model.dart';
import '../../../Views/products_list_view.dart';

class SearchStoreMobileView extends StatefulWidget {
  const SearchStoreMobileView({Key? key, required this.storesCore}) : super(key: key);
  final List<StoresModel>? storesCore;

  @override
  State<SearchStoreMobileView> createState() => _SearchStoreMobileViewState();
}

class _SearchStoreMobileViewState extends State<SearchStoreMobileView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  late ProductsViewModel productsViewModel;

  @override
  void initState() {
    // TODO: implement initState
    productsViewModel = Provider.of<ProductsViewModel>(context, listen: false);

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
                onTap: (){

                },
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
                              await productsViewModel.searchForStoreProduct(val,context);
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
        body: productsViewModel.status1 == Status.loading ?
        Center(child: CircularProgressIndicator(color: AppColors.primary,),):
        Container(
            child: Column(
              children: [
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      return false;
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
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
                                  ((deviceSize.width * 0.6 - 25) / 180),
                                  children: List.generate(
                                    productsViewModel.storeCoreSearch.length,
                                        (index) {
                                      return Container(
                                        height: 100,
                                        width: 100,
                                        color: Colors.redAccent,
                                      );
                                      // return InkWell(
                                      //   onTap: () {
                                      //     Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) =>
                                      //                 ProductsListView(
                                      //                   productId:productsViewModel.storeCoreSearch[index]
                                      //                       ?.id ?? 0, storeName: productsViewModel.storeCoreSearch[index]?.name ?? "",)));
                                      //   },
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.only(right: 10),
                                      //     child: Container(
                                      //       height: 150,
                                      //       child: Padding(
                                      //         padding: const EdgeInsets.symmetric(
                                      //             horizontal: 15),
                                      //         child: Center(
                                      //           child: Column(
                                      //             children: [
                                      //               Container(
                                      //                 height: 100,
                                      //                 width: 150,
                                      //                 decoration: BoxDecoration(
                                      //                   color: Colors.white,
                                      //                   image: DecorationImage(
                                      //                     image: NetworkImage(
                                      //                         productsViewModel.storeCoreSearch[
                                      //                         index]
                                      //                             ?.commerialAttachment ?? ""),
                                      //                     fit: BoxFit.cover,
                                      //                   ),
                                      //                   borderRadius:
                                      //                   BorderRadius.circular(5),
                                      //                 ),
                                      //               ),
                                      //               // Container(
                                      //               //   decoration: ,
                                      //               //   child: Image.network(homeViewModel
                                      //               //       .homeCore!
                                      //               //       .homeFeatureCategory![index]
                                      //               //       .image!,fit: BoxFit.fill,height: 100,width: 150,),
                                      //               // ),
                                      //               Text(
                                      //                 productsViewModel.storeCoreSearch[
                                      //                 index]
                                      //                     ?.name ?? "mostafa",
                                      //                 style: const TextStyle(
                                      //                     fontFamily:
                                      //                     AppFonts.cairoFontRegular,
                                      //                     fontSize: 18.0),
                                      //               ),
                                      //             ],
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // );
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
