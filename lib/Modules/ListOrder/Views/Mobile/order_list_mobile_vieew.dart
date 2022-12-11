import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meem_app/Modules/ListOrder/ViewModel/order_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../CommonWidget/main_button.dart';
import '../../../../CommonWidget/title_appbar.dart';
import '../../../../Constants/app_colors.dart';
import '../../../../Constants/app_enums.dart';
import '../../../../Constants/app_fonts.dart';
import '../../../../Localization/app_localization.dart';

class OrderListMobileView extends StatefulWidget {
  const OrderListMobileView({Key? key}) : super(key: key);
  static String id = 'orderListScreen';

  @override
  State<OrderListMobileView> createState() => _OrderListMobileViewState();
}

class _OrderListMobileViewState extends State<OrderListMobileView> {
  final ScrollController _scrollController = ScrollController();

  late OrderListViewModel orderListViewModel;
  int _counter = 1;
  bool isSelected = false;
  bool isVisible1 = false;
  String order_status = "";

  @override
  void initState() {
    orderListViewModel =
        Provider.of<OrderListViewModel>(context, listen: false);

    Future(() async {
      await orderListViewModel.listOrder(context);
    });
    callThisMethod(isVisible1);
    super.initState();
  }

  void callThisMethod(bool isVisible) {
    debugPrint('_OrderList.callThisMethod: isVisible: ${isVisible}');
    if (isVisible) {
      orderListViewModel.listOrder(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    orderListViewModel = Provider.of<OrderListViewModel>(context, listen: true);
    return VisibilityDetector(
      key: Key(OrderListMobileView.id),
      onVisibilityChanged: (VisibilityInfo info) {
        bool isVisible = info.visibleFraction != 0;
        callThisMethod(isVisible);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: TitleAppBar(
            title: getTranslated(context, "my_orders"),
          ),
          elevation: 0,
        ),
        body: orderListViewModel.secondaryStatus == Status.loading ||
                orderListViewModel.orderListCoreModel == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MainButton1(
                          text: getTranslated(context, "my_orders"),
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
                                          GestureDetector(
                                            onTap: () {
                                              orderListViewModel.order_status =
                                                  "pending";
                                              orderListViewModel
                                                  .listOrder(context);
                                              Navigator.pop(context);
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
                                          GestureDetector(
                                            onTap: () {
                                              orderListViewModel.order_status =
                                                  "inprogress";
                                              orderListViewModel
                                                  .listOrder(context);
                                              Navigator.pop(context);
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
                                          GestureDetector(
                                            onTap: () {
                                              orderListViewModel.order_status =
                                                  "delivered";
                                              orderListViewModel
                                                  .listOrder(context);
                                              Navigator.pop(context);
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
                                          GestureDetector(
                                            onTap: () {
                                              orderListViewModel.order_status =
                                                  "cancelled";
                                              orderListViewModel
                                                  .listOrder(context);
                                              Navigator.pop(context);
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
                    ...List.generate(
                        orderListViewModel.orderListCoreModel?.order?.length ??
                            0,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blueGrey, width: 0.4),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          10.0) //                 <--- border radius here
                                      ),
                                ),
                                height: deviceSize.height * 0.102,
                                width: deviceSize.width * 0.85,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            getTranslated(context, "order_no") +
                                                "${orderListViewModel.orderListCoreModel?.order?[index].orderNumber ?? ""}",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                height: 1.6,
                                                color: AppColors.black,
                                                fontFamily:
                                                    AppFonts.cairoFontBold,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            orderListViewModel
                                                    .orderListCoreModel
                                                    ?.order?[index]
                                                    .createdAt ??
                                                "",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                height: 1.6,
                                                color: AppColors.grey135,
                                                fontFamily:
                                                    AppFonts.cairoFontRegular,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                getTranslated(
                                                        context, "order_stat")
                                                   ,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    height: 1.6,
                                                    color: AppColors.grey135,
                                                    fontFamily: AppFonts
                                                        .cairoFontRegular,
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                getTranslated(context, orderListViewModel
                                                    .orderListCoreModel
                                                    ?.order?[index]
                                                    .status ??
                                                    ""),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    height: 1.6,
                                                    color: orderListViewModel
                                                                .orderListCoreModel
                                                                ?.order?[index]
                                                                .status ==
                                                            "pending"
                                                        ? AppColors
                                                            .pendingOrange
                                                        : orderListViewModel
                                                                    .orderListCoreModel
                                                                    ?.order?[
                                                                        index]
                                                                    .status ==
                                                                "inprogress"
                                                            ? AppColors.fbBlue
                                                            : orderListViewModel
                                                                        .orderListCoreModel
                                                                        ?.order?[
                                                                            index]
                                                                        .status ==
                                                                    "cancelled"
                                                                ? AppColors
                                                                    .declinedRed
                                                                : orderListViewModel
                                                                            .orderListCoreModel
                                                                            ?.order?[
                                                                                index]
                                                                            .status ==
                                                                        "delivered"
                                                                    ? AppColors
                                                                        .green2
                                                                    : AppColors
                                                                        .primary,
                                                    fontFamily: AppFonts
                                                        .cairoFontRegular,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            orderListViewModel
                                                    .orderListCoreModel
                                                    ?.order?[index]
                                                    .storeName ??
                                                "",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                height: 1.6,
                                                color: AppColors.black,
                                                fontFamily:
                                                    AppFonts.cairoFontRegular,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                  ],
                ),
              ),
      ),
    );
  }
}
