import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Order/ViewModel/order_view_model.dart';
import 'package:meem_app/Modules/Order/Views/order_succuss_view.dart';
import 'package:meem_app/Modules/Service%20Provider/Order/ViewModel/sp_order_list_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../CommonWidget/main_button.dart';
import '../../../../../CommonWidget/title_appbar.dart';
import '../../../../../CommonWidget/toast.dart';
import '../../../../../Constants/app_assets.dart';
import '../../../../../Constants/app_colors.dart';
import '../../../../../Constants/app_enums.dart';
import '../../../../../Constants/app_fonts.dart';
import '../../../../../Localization/app_localization.dart';



class SpOrderDetailsMobileView extends StatefulWidget {
  final int? product_id;


  SpOrderDetailsMobileView(
      {Key? key,
        required this.product_id,
      })
      : super(key: key);

  @override
  State<SpOrderDetailsMobileView> createState() => _SpOrderDetailsMobileViewState();
}

class _SpOrderDetailsMobileViewState extends State<SpOrderDetailsMobileView> {
  late SpOrderListViewModel orderViewModel;

  void initState() {
    // TODO: implement initState
    // addressViewModel = Provider.of<AddressViewModel>(context, listen: false);
    orderViewModel = Provider.of<SpOrderListViewModel>(context, listen: false);
    Future(() async {
      await orderViewModel.orderSummary(widget.product_id!,context);
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    orderViewModel = Provider.of<SpOrderListViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: TitleAppBar(
          title: getTranslated(context, "order_review"),
        ),
        elevation: 0,
      ),
      body:  orderViewModel.secondaryStatus == Status.loading || orderViewModel.orderSummryCoreModel == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  getTranslated(context, "title_order_summary"),
                  style: const TextStyle(
                      fontFamily: AppFonts.cairoFontRegular,
                      fontSize: 16),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height * 0.4,
              // color: Colors.blueGrey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Text("${orderViewModel.orderSummryCoreModel?.orderItem?.length ?? 0}"),

                    ...List.generate(
                        orderViewModel.orderSummryCoreModel?.orderItem?.length ?? 0,
                            (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
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
                                          imageUrl:  '${orderViewModel.orderSummryCoreModel?.orderItem?[index].product?.image}',
                                          errorWidget: (context, url, _) => Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  "${orderViewModel.orderSummryCoreModel?.orderItem?[index].product?.image}",
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) => Container(
                                            decoration:  BoxDecoration(
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
                                              orderViewModel.orderSummryCoreModel?.orderItem?[index].product?.name ?? "",
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
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(

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
                                                        orderViewModel.orderSummryCoreModel?.orderItem?[index].product?.store ?? "",
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
                                                SizedBox(height: 15,),
                                                Row(

                                                  children: [
                                                    Container(
                                                      alignment: setAlignmnetToCenterStart(context),
                                                      child: SelectableText(
                                                        "${getTranslated(context, "qty")} ",
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
                                                        '${ orderViewModel.orderSummryCoreModel?.orderItem?[index].quantity ?? 0} ',
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
                                          " ${orderViewModel.orderSummryCoreModel?.orderItem?[index].amount}ر.س ",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: AppFonts.cairoFontBold, fontSize: 18,color: AppColors.primary),

                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  getTranslated(context, "add"),
                  style: const TextStyle(
                      fontFamily: AppFonts.cairoFontSemiBold,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  orderViewModel.orderSummryCoreModel?.address ?? "",
                  style: const TextStyle(
                      fontFamily: AppFonts.cairoFontRegular,
                      fontSize: 15),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  getTranslated(context, "pay"),
                  style: const TextStyle(
                      fontFamily: AppFonts.cairoFontSemiBold,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  orderViewModel.orderSummryCoreModel?.paymentType ?? "",
                  style: const TextStyle(
                      fontFamily: AppFonts.cairoFontRegular,
                      fontSize: 15),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MainButton1(
                text: getTranslated(context, "order_status"),
                width: deviceSize.width * 0.8,
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10))),
                      builder: (context) => Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  orderViewModel
                                      .order_status1 = "pending";
                                  // filterTitle = "pending";
                                  orderViewModel
                                      .changeOrderStatus(widget.product_id!,context);
                                  Navigator.pop(context);
                                });
                              },
                              child: Text(
                                getTranslated(context, "pending"),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    height: 1.6,
                                    color: AppColors.primary,
                                    fontFamily:
                                    AppFonts.cairoFontRegular,
                                    fontSize: 18),
                              ),
                            ),

                            TextButton(
                              onPressed: () {
                                setState(() {
                                  orderViewModel
                                      .order_status1 =
                                  "inprogress";
                                  // filterTitle = "inprogress";
                                  orderViewModel
                                      .changeOrderStatus(widget.product_id!,context);
                                  Navigator.pop(context);
                                });
                              },
                              child: Text(
                                getTranslated(
                                    context, "inprogress"),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    height: 1.6,
                                    color: AppColors.primary,
                                    fontFamily:
                                    AppFonts.cairoFontRegular,
                                    fontSize: 18),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  orderViewModel.order_status1 =
                                  "delivered";
                                  // filterTitle = "delivered";
                                  orderViewModel
                                      .changeOrderStatus(widget.product_id!,context);
                                  Navigator.pop(context);
                                });
                              },
                              child: Text(
                                getTranslated(
                                    context, "delivered"),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    height: 1.6,
                                    color: AppColors.primary,
                                    fontFamily:
                                    AppFonts.cairoFontRegular,
                                    fontSize: 18),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  // orderListViewModel.order_status =
                                  // "cancelled";
                                  // filterTitle = "cancelled";
                                  // orderListViewModel
                                  //     .listOrder(context);
                                  Navigator.pop(context);
                                });
                              },
                              child: Text(
                                getTranslated(
                                    context, "cancelled"),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    height: 1.6,
                                    color: AppColors.primary,
                                    fontFamily:
                                    AppFonts.cairoFontRegular,
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ));
                },
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 20.0),
          //   child: MainButton(
          //     text: getTranslated(context, "order_status"),
          //     width: deviceSize.width * 0.9,
          //     onPressed: () async {
          //       // bool result = await orderViewModel.placeOrder(widget.address_id, widget.payment_type, context);
          //       // if(result){
          //       //   Navigator.push(context, MaterialPageRoute(builder: (context) => OrderSuccessView() ));
          //       // }  else {
          //       //   toastAppErr(
          //       //       "Order does not Placed Successfully ",
          //       //       contest: context);
          //       // }
          //
          //
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
