import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Order/ViewModel/order_view_model.dart';
import 'package:meem_app/Modules/Order/Views/order_succuss_view.dart';
import 'package:provider/provider.dart';

import '../../../../CommonWidget/main_button.dart';
import '../../../../CommonWidget/title_appbar.dart';
import '../../../../CommonWidget/toast.dart';
import '../../../../Constants/app_assets.dart';
import '../../../../Constants/app_colors.dart';
import '../../../../Constants/app_enums.dart';
import '../../../../Constants/app_fonts.dart';
import '../../../../Localization/app_localization.dart';
import '../../Model/order_summry_core_model.dart';

class OrderDetailsMobileView extends StatefulWidget {
  final int payment_type;
  final int address_id;


  OrderDetailsMobileView(
      {Key? key,
      required this.payment_type,
      required this.address_id,
      })
      : super(key: key);

  @override
  State<OrderDetailsMobileView> createState() => _OrderDetailsMobileViewState();
}

class _OrderDetailsMobileViewState extends State<OrderDetailsMobileView> {
  late OrderViewModel orderViewModel;

  void initState() {
    // TODO: implement initState
    // addressViewModel = Provider.of<AddressViewModel>(context, listen: false);
    orderViewModel = Provider.of<OrderViewModel>(context, listen: false);
    Future(() async {
      await orderViewModel.orderSummary(widget.address_id,widget.payment_type,context);
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    orderViewModel = Provider.of<OrderViewModel>(context, listen: true);
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
                                                imageUrl: "http://164.92.185.162/public/" + '${orderViewModel.orderSummryCoreModel?.orderItem?[index].product?.image}',
                                                errorWidget: (context, url, _) => Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        "http://164.92.185.162/public/" + "${orderViewModel.orderSummryCoreModel?.orderItem?[index].product?.image}",
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
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: MainButton(
                    text: getTranslated(context, "order_review"),
                    width: deviceSize.width * 0.9,
                    onPressed: () async {
                      bool result = await orderViewModel.placeOrder(widget.address_id, widget.payment_type, context);
                      if(result){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderSuccessView() ));
                      }  else {
                        toastAppErr(
                            "Order does not Placed Successfully ",
                            contest: context);
                      }


                    },
                  ),
                ),
              ],
            ),
    );
  }
}
