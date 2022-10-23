import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meem_app/CommonWidget/search_appbar.dart';
import 'package:meem_app/Constants/app_assets.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';

class StoresMobileView extends StatefulWidget {
  const StoresMobileView({Key? key}) : super(key: key);

  @override
  State<StoresMobileView> createState() => _StoresMobileViewState();
}

class _StoresMobileViewState extends State<StoresMobileView> {
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
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Row(
              children: [
                SelectableText(
                  "${getTranslated(context, "stores")} 'ازياء رجالية'",
                  style: const TextStyle(
                      fontFamily: AppFonts.cairoFontSemiBold, fontSize: 18),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                  decoration: BoxDecoration(
                      color: AppColors.offWhite,
                      borderRadius: BorderRadius.circular(13)),
                  child: Text(
                    getTranslated(context, "closest_to_you"),
                    style: const TextStyle(
                        fontFamily: AppFonts.cairoFontSemiBold,
                        fontSize: 17,
                        color: AppColors.primary),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                // if (scrollNotification.metrics.pixels ==
                //         scrollNotification.metrics.maxScrollExtent &&
                //     vendorsViewModel!.status != Status.loading) {
                //   vendorsViewModel!.fetchVendorsByCategoryID(
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
                        childAspectRatio: ((deviceSize.width * 0.5 - 25) / 190),
                        children: List.generate(
                          6,
                          (index) {
                            return StoreItemWidget(
                              img: AppAssets.testZara,
                              onPressed: () {},
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

class StoreItemWidget extends StatelessWidget {
  const StoreItemWidget({
    Key? key,
    required this.img,
    required this.onPressed,
  }) : super(key: key);

  final String img;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.grey217,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: CachedNetworkImage(
          imageUrl: "h",
          errorWidget: (context, url, _) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(img),
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(img),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
