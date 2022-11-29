import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_colors.dart';

import '../../../../CommonWidget/search_appbar.dart';
import '../../../../Constants/app_fonts.dart';
import '../../../../Models/HomeModel/HomeFeaturedCategoryModel.dart';
import '../../../../Models/HomeModel/store_model.dart';
import '../products_list_view.dart';

class ProductStoreMobileView extends StatefulWidget {
  final List<StoresModel>? storesCore;
  const ProductStoreMobileView({Key? key, required this.storesCore}) : super(key: key);

  @override
  State<ProductStoreMobileView> createState() => _ProductStoreMobileViewState();
}

class _ProductStoreMobileViewState extends State<ProductStoreMobileView> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: const SearchAppBar(),
        elevation: 0,
      ),
      body: widget.storesCore != null ?
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
                                widget.storesCore!.length,
                                    (index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductsListView(
                                                    productId: widget.storesCore![index]
                                                        .id ?? 0, storeName: widget.storesCore![index].name ?? "",)));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Container(
                                        height: 150,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 100,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          widget.storesCore![
                                                          index]
                                                              .commerialAttachment!),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                  ),
                                                ),
                                                // Container(
                                                //   decoration: ,
                                                //   child: Image.network(homeViewModel
                                                //       .homeCore!
                                                //       .homeFeatureCategory![index]
                                                //       .image!,fit: BoxFit.fill,height: 100,width: 150,),
                                                // ),
                                                Text(
                                                  widget.storesCore![index]
                                                      .name!,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                      AppFonts.cairoFontRegular,
                                                      fontSize: 18.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
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
      ) : Center(child: CircularProgressIndicator(color: AppColors.primary,),)
    );
  }
}
