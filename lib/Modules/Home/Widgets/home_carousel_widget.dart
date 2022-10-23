import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:meem_app/Models/HomeModel/HomeCarouselModel.dart';
import 'package:meem_app/Modules/Home/ViewModel/home_view_model.dart';

import 'Carousel.dart';

class HomeCarousel extends StatelessWidget {
  var sliders;
  var h;

  HomeCarousel(
      List<HomeCarouselModel> typ, double hiegh) {
    sliders = typ;
    h = hiegh;

  }

  // void navigateToAllProductsAndRefresh(BuildContext context) async {
  //   final result = await Navigator.push(context,
  //       PageTransition(type: StorageHelper().getLang() == 'en' ? PageTransitionType.leftToRight :PageTransitionType.rightToLeft, child: const AllProductsPageScreen()));
  //   print("result is :: $result");
  //   if(result != null){
  //     manager.fetchCartCountData(HomeCore.customerId); // call your own function here to refresh screen
  //   }
  // }

  // void navigateAndRefresh(BuildContext context) async {
  //   final result = await Navigator.push(context,
  //       PageTransition(type:StorageHelper().getLang() == 'en' ? PageTransitionType.leftToRight :PageTransitionType.rightToLeft, child: ProductDetailsScreen()));
  //   print("result is :: $result");
  //   if(result != null){
  //     manager.fetchCartCountData(HomeCore.customerId); // call your own function here to refresh screen
  //   }
  // }
// is_product=1  => redirect to item details,
  // is_product= 0 =>  redirect to all products page with category
  // is_product=2 =>  redirect to all products page  with brand
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: h,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: sliders!.isNotEmpty
              ? Carousel(
                  overlayShadow: true,
                  borderRadius: true,
                  boxFit: BoxFit.cover,
                  radius: const Radius.circular(40),
                  overlayShadowColors: Colors.transparent,
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.white,
                  dotIncreasedColor: Colors.black,
                  dotIncreaseSize: 5.0,
                  showIndicator: false,
                  dotSpacing: 10,
                  autoplay: true,
                  dotSize: double.parse(sliders!.length.toString()),
                  images: sliders!.map((HomeCarouselModel element) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Colors.transparent),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              // child: FadeInImage.memoryNetwork(
                              //     image: Endpoints.imgPath + element.image!,
                              //     placeholder: kTransparentImage,
                              // )
                              child: CachedNetworkImage(
                                imageUrl: element.image!,
                                errorWidget: (context, urfixl, error) =>
                                    const Icon(Icons.error),
                              ),
                            ));
                      },
                    );
                  }).toList(),
                )
              : const SizedBox()),
    );
  }
}
