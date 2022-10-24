import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meem_app/CommonWidget/search_bar.dart';
import 'package:meem_app/Constants/app_assets.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Modules/Home/ViewModel/home_view_model.dart';
import 'package:meem_app/Modules/Products/Views/Mobile/products_list_mobile_view.dart';
import 'package:meem_app/Modules/Products/Views/products_list_view.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Views/add_product_view.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../Constants/app_enums.dart';
import '../../../../Constants/app_fonts.dart';
import '../../../Authentication/authentication_navigations.dart';
import '../../Widgets/home_carousel_widget.dart';

class HomeMobileView extends StatefulWidget {
  const HomeMobileView({Key? key}) : super(key: key);
  static String id = 'homeScreen';

  @override
  State<HomeMobileView> createState() => _HomeMobileViewState();
}

class _HomeMobileViewState extends State<HomeMobileView> {
  late HomeViewModel homeViewModel;
  bool isVisible1 = false;
  @override
  void initState() {
    homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    Future(() async {
      await homeViewModel.homeFetchingData(context);
    });
    callThisMethod(isVisible1);

    super.initState();
  }

  void callThisMethod(bool isVisible){
    debugPrint('_HomeScreenState.callThisMethod: isVisible: ${isVisible}');
    if(isVisible) {
        homeViewModel.homeFetchingData(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    homeViewModel = Provider.of<HomeViewModel>(context, listen: true);
    return VisibilityDetector(
      key: Key(HomeMobileView.id),
      onVisibilityChanged: (VisibilityInfo info) {
        bool isVisible = info.visibleFraction != 0;
        callThisMethod(isVisible);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: const HomeAppBar(),
          toolbarHeight: 120,
          elevation: 0,
        ),
        body: SizedBox(
          height: deviceSize.height,
          child: homeViewModel.secondaryStatus == Status.loading ||
                  homeViewModel.homeCore == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeCarousel(
                          homeViewModel.homeCore!.homeCarousel!,
                          200,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Text(
                            getTranslated(context, "featured_category"),
                            style: const TextStyle(
                                fontFamily: AppFonts.cairoFontSemiBold,
                                fontSize: 22.0),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              ...List.generate(
                                homeViewModel
                                    .homeCore!.homeFeatureCategory!.length,
                                (index) => InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductsListView(
                                                  productId: homeViewModel
                                                      .homeCore!
                                                      .homeFeatureCategory![index]
                                                      .id, storeName: homeViewModel.homeCore!.homeFeatureCategory![index].name,)));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      height: 150,
                                      // decoration: selectedIndex ==
                                      //     index
                                      //     ? const BoxDecoration(
                                      //     border: Border(
                                      //         bottom:
                                      //         BorderSide(
                                      //           color: accentColor,
                                      //           width:
                                      //           2.0, // This would be the width of the underline
                                      //         )))
                                      //     : const BoxDecoration(),
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
                                                        homeViewModel
                                                            .homeCore!
                                                            .homeFeatureCategory![
                                                                index]
                                                            .image!),
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
                                                homeViewModel
                                                    .homeCore!
                                                    .homeFeatureCategory![index]
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
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Text(
                            getTranslated(context, "featured_store"),
                            style: const TextStyle(
                                fontFamily: AppFonts.cairoFontSemiBold,
                                fontSize: 22.0),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              ...List.generate(
                                homeViewModel.homeCore!.homeFeatureStores!.length,
                                (index) => InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductsListView(
                                                  productId: homeViewModel
                                                      .homeCore!
                                                      .homeFeatureStores![index]
                                                      .id, storeName: homeViewModel.homeCore!.homeFeatureStores![index].name,)));
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
                                                        homeViewModel
                                                            .homeCore!
                                                            .homeFeatureStores![
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
                                                homeViewModel
                                                    .homeCore!
                                                    .homeFeatureStores![index]
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
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Text(
                            getTranslated(context, "celebrity_stores"),
                            style: const TextStyle(
                                fontFamily: AppFonts.cairoFontSemiBold,
                                fontSize: 22.0),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              ...List.generate(
                                homeViewModel
                                    .homeCore!.homeCelebrityStores!.length,
                                (index) => InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductsListView(
                                                  productId: homeViewModel
                                                      .homeCore!
                                                      .homeCelebrityStores![index]
                                                      .id, storeName: homeViewModel.homeCore!.homeCelebrityStores![index].name,)));
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
                                                        homeViewModel
                                                            .homeCore!
                                                            .homeCelebrityStores![
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
                                                homeViewModel
                                                    .homeCore!
                                                    .homeCelebrityStores![index]
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
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Text(
                            getTranslated(context, "recently_added_stores"),
                            style: const TextStyle(
                                fontFamily: AppFonts.cairoFontSemiBold,
                                fontSize: 22.0),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              ...List.generate(
                                homeViewModel.homeCore!.homeRecentlyAdded!.length,
                                (index) => InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductsListView(
                                                    productId: homeViewModel
                                                        .homeCore!
                                                        .homeRecentlyAdded![index]
                                                        .id, storeName: homeViewModel.homeCore!.homeRecentlyAdded![index].name,)));
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
                                                        homeViewModel
                                                            .homeCore!
                                                            .homeRecentlyAdded![
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
                                                homeViewModel
                                                    .homeCore!
                                                    .homeRecentlyAdded![index]
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
                                ),
                              )
                            ],
                          ),
                        ),
                      ]),
                ),
        ),
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      color: AppColors.white,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            alignment: setAlignmnetToCenterStart(context),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset(
              AppAssets.logo,
              width: 75,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SearchBar(
            searchcontroller: TextEditingController(),
            width: deviceSize.width * 0.95,
          ),
        ],
      )),
    );
  }
}
