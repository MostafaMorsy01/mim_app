import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meem_app/CommonWidget/main_button.dart';
import 'package:meem_app/CommonWidget/quantity_changer.dart';

import 'package:meem_app/CommonWidget/title_appbar.dart';
import 'package:meem_app/Constants/app_assets.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Modules/Cart/ViewModel/cart_view_model.dart';
import 'package:meem_app/Modules/Cart/ViewModel/delete_cart_item_view_model.dart';
import 'package:meem_app/Modules/Cart/ViewModel/update_cart_view_model.dart';
import 'package:meem_app/Modules/Order/Views/Mobile/order_payment_method_mobile_view.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../Constants/app_enums.dart';
import '../../../Order/Views/order_payment_method_view.dart';

class MyCartMobileView extends StatefulWidget {
  const MyCartMobileView({Key? key}) : super(key: key);
  static String id = 'cartScreen';

  @override
  State<MyCartMobileView> createState() => _MyCartMobileViewState();
}

class _MyCartMobileViewState extends State<MyCartMobileView> {
  final ScrollController _scrollController = ScrollController();
  late CartViewModel cartViewModel;
  late DeleteItemCartViewModel deleteItemCartViewModel;
  late UpdateCartViewModel updateCartViewModel;
  int _counter = 1;
  bool isSelected = false;
  bool isVisible1 = false;

  @override
  void initState() {
    cartViewModel = Provider.of<CartViewModel>(context, listen: false);
    deleteItemCartViewModel =
        Provider.of<DeleteItemCartViewModel>(context, listen: false);
    updateCartViewModel =
        Provider.of<UpdateCartViewModel>(context, listen: false);
    Future(() async {
      await cartViewModel.cartFetchingData(context);
    });
    callThisMethod(isVisible1);
    super.initState();
  }

  void callThisMethod(bool isVisible) {
    debugPrint('_CartView.callThisMethod: isVisible: ${isVisible}');
    if (isVisible) {
      cartViewModel.cartFetchingData(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    cartViewModel = Provider.of<CartViewModel>(context, listen: true);
    return VisibilityDetector(
      key: Key(MyCartMobileView.id),
      onVisibilityChanged: (VisibilityInfo info) {
        bool isVisible = info.visibleFraction != 0;
        callThisMethod(isVisible);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: TitleAppBar1(
            title: getTranslated(context, "shopping_cart"),
          ),
          elevation: 0,
        ),
        body: cartViewModel.secondaryStatus == Status.loading ||
                cartViewModel.cartCore == null ||
                deleteItemCartViewModel.secondaryStatus == Status.loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        return false;
                      },
                      child: Center(
                          child: Scrollbar(
                        controller: _scrollController,
                        child: CustomScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.vertical,
                          physics: const AlwaysScrollableScrollPhysics(),
                          slivers: <Widget>[
                            SliverGrid.count(
                              crossAxisCount: 1,
                              //crossAxisSpacing: 10.0,
                              //mainAxisSpacing: 5.0,
                              childAspectRatio: deviceSize.width / 210,
                              children: List.generate(
                                cartViewModel.cartCore?.cartItem?.length ?? 0,
                                (index) {
                                  return CartItemWidget(
                                    cartViewModel: cartViewModel,
                                      qty: cartViewModel.cartCore
                                              ?.cartItem?[index].quantity ??
                                          0,
                                      img: cartViewModel
                                              .cartCore
                                              ?.cartItem?[index]
                                              .product
                                              ?.image ??
                                          "",
                                      name: cartViewModel
                                              .cartCore
                                              ?.cartItem?[index]
                                              .product
                                              ?.name ??
                                          "",
                                      price: cartViewModel
                                              .cartCore
                                              ?.cartItem?[index]
                                              .product
                                              ?.price ??
                                          0,
                                      store: cartViewModel
                                              .cartCore
                                              ?.cartItem?[index]
                                              .product
                                              ?.store ??
                                          "",
                                      Id: cartViewModel
                                          .cartCore!
                                          .cartItem![index]
                                          .id ??
                                          0,

                                      updateCartViewModel: updateCartViewModel,

                                      onDelete: () async {
                                        bool result =
                                            await deleteItemCartViewModel
                                                .deleteFromCart(
                                                    cartViewModel
                                                            .cartCore!
                                                            .cartItem![index]
                                                            .id ??
                                                        0,
                                                    context);

                                        if (result) {
                                          await cartViewModel
                                              .cartFetchingData(context);
                                        }
                                      });
                                },
                              ),
                            ),
                          ],
                        ),
                      )),
                    ),
                  ),
                  Container(
                    //height: 230,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: AppColors.grey217, width: 1))),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: setAlignmnetToCenterStart(context),
                              child: SelectableText(
                                getTranslated(context, "summation"),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontFamily: AppFonts.cairoFontSemiBold,
                                    fontSize: 17,
                                    color: AppColors.black),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              alignment: setAlignmnetToCenterStart(context),
                              child: SelectableText(
                                "${cartViewModel.cartCore?.subTotal ?? 0} ر.س ",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily: AppFonts.cairoFontRegular,
                                    fontSize: 18,
                                    color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: setAlignmnetToCenterStart(context),
                              child: SelectableText(
                                getTranslated(context, "shipping"),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontFamily: AppFonts.cairoFontSemiBold,
                                    fontSize: 17,
                                    color: AppColors.black),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              alignment: setAlignmnetToCenterStart(context),
                              child: SelectableText(
                                "${cartViewModel.cartCore?.shipmentFees ?? 0} ر.س ",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily: AppFonts.cairoFontRegular,
                                    fontSize: 18,
                                    color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              alignment: setAlignmnetToCenterStart(context),
                              child: SelectableText(
                                getTranslated(context, "total"),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontFamily: AppFonts.cairoFontBold,
                                    fontSize: 20,
                                    color: AppColors.black),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              alignment: setAlignmnetToCenterStart(context),
                              child: SelectableText(
                                "${cartViewModel.cartCore?.total ?? 0} ر.س ",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily: AppFonts.cairoFontBold,
                                    fontSize: 18,
                                    color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  MainButton(
                    text: getTranslated(context, "complete_purchase"),
                    width: deviceSize.width * 0.9,
                    onPressed: () {
                      print("carttt");
                      print(cartViewModel.cartCore?.cartItem?.length);
                      if(cartViewModel.cartCore?.cartItem?.length != null){
                        Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new OrderPaymentView()));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  CartItemWidget(
      {Key? key,
      required this.img,
      required this.Id,
      required this.store,
      required this.name,
      required this.price,
      required this.qty,
      required this.onDelete,
      required this.updateCartViewModel,
        required this.cartViewModel
      })
      : super(key: key);

  final Function onDelete;
  final int Id;
  final String img;
  final String name;
  final String store;
  final int price;
  final int qty;
  late UpdateCartViewModel updateCartViewModel;
  late CartViewModel cartViewModel;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Container(
                width: 115,
                height: 115,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.grey217,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: "http://164.92.185.162/public/" + img,
                  errorWidget: (context, url, _) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          "http://164.92.185.162/public/" + img,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          AppAssets.testShoes,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: deviceSize.width * 0.4,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      name,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: AppFonts.cairoFontSemiBold, fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          alignment: setAlignmnetToCenterStart(context),
                          child: SelectableText(
                            "${getTranslated(context, "store")} ",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontFamily: AppFonts.cairoFontSemiBold,
                                fontSize: 15,
                                height: 0.8,
                                color: AppColors.grey162),
                          ),
                        ),
                        Container(
                          alignment: setAlignmnetToCenterStart(context),
                          child: SelectableText(
                            store,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: AppFonts.cairoFontSemiBold,
                                fontSize: 18,
                                height: 0.8,
                                color: AppColors.black),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Spacer(),
              // IconButton(
              //   onPressed: () {},
              //   icon: const ImageIcon(
              //     AssetImage(AppAssets.favRedOutlined),
              //     color: AppColors.primary,
              //     size: 32,
              //   ),
              // )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                alignment: setAlignmnetToCenterStart(context),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  " $priceر.س ",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: AppFonts.cairoFontBold, fontSize: 18),
                ),
              ),
              SizedBox(
                width: 140,
                child: QuantityChanger(
                  qty: qty,
                  id: Id,
                  updateCartViewModel: updateCartViewModel,
                  cartViewModel: cartViewModel,

                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  onDelete();
                },
                icon: const ImageIcon(
                  AssetImage(AppAssets.trashOutlined),
                  color: AppColors.favRed,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          color: AppColors.grey217,
          thickness: 1,
        )
      ],
    );
  }
}
