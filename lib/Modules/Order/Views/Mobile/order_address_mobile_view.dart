import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Order/Views/order_details_view.dart';
import 'package:provider/provider.dart';

import '../../../../CommonWidget/main_button.dart';
import '../../../../CommonWidget/title_appbar.dart';
import '../../../../CommonWidget/toast.dart';
import '../../../../Constants/app_colors.dart';
import '../../../../Constants/app_enums.dart';
import '../../../../Constants/app_fonts.dart';
import '../../../../Localization/app_localization.dart';
import '../../../Address/ViewModel/address_view_model.dart';
import '../../../Address/Views/address_list_view.dart';
import '../../../Authentication/Widgets/selectable_circle_widget.dart';
import '../../ViewModel/order_view_model.dart';

class OrderAddressMobileView extends StatefulWidget {
  final int payment_id;

  const OrderAddressMobileView({Key? key, required this.payment_id})
      : super(key: key);

  @override
  State<OrderAddressMobileView> createState() => _OrderAddressMobileViewState();
}

class _OrderAddressMobileViewState extends State<OrderAddressMobileView> {
  late AddressViewModel addressViewModel;
  late OrderViewModel orderViewModel;
  bool isVisible1 = false;
  bool isSelected = false;
  int? address_id;
  int? selectedIndex;

  @override
  void initState() {
    // TODO: implement initState
    addressViewModel = Provider.of<AddressViewModel>(context, listen: false);
    orderViewModel = Provider.of<OrderViewModel>(context, listen: false);

    Future(() async {
      await addressViewModel.addressFetchingData(context);
    });

    callThisMethod(isVisible1);
    super.initState();
  }

  void callThisMethod(bool isVisible) {
    debugPrint('_AddressScreen.callThisMethod: isVisible: ${isVisible}');
    addressViewModel.addressFetchingData(context);
  }

  @override
  Widget build(BuildContext context) {
    orderViewModel = Provider.of<OrderViewModel>(context, listen: true);
    addressViewModel = Provider.of<AddressViewModel>(context, listen: true);
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: TitleAppBar(
          title: getTranslated(context, "my_addresses"),
        ),
        elevation: 0,
      ),
      body: addressViewModel.secondaryStatus == Status.loading ||
              addressViewModel.addressCore == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Container(
                        child: (addressViewModel.addressCore?.address?.length ==
                                null)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 50),
                                    child: MainButton(
                                      text:
                                          getTranslated(context, "new_Address"),
                                      width: deviceSize.width * 0.9,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddressListView()));
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...List.generate(
                                    addressViewModel
                                            .addressCore?.address?.length ??
                                        0,
                                    (index) => InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                          print(selectedIndex);
                                          address_id = addressViewModel
                                              .addressCore?.address?[index].id;
                                          print(address_id);
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 20.0,
                                          right: 20.0,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: selectedIndex == index
                                                    ? AppColors.blue1
                                                    : AppColors.white,
                                                border: Border.all(
                                                    color: AppColors.blue1,
                                                    width: 2.0),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.5),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: SelectableText(
                                                "${addressViewModel.addressCore?.address?[index].name ?? ""}  ${addressViewModel.addressCore?.address?[index].street ?? ""} ${addressViewModel.addressCore?.address?[index].area ?? ""}",
                                                style: const TextStyle(
                                                    fontFamily: AppFonts
                                                        .cairoFontRegular,
                                                    fontSize: 17.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Padding(
                                    //   padding: const EdgeInsets.only(top:10.0,right: 20.0, ),
                                    //   child: ListTile(
                                    //     title:  Text('${addressViewModel.addressCore?.address?[index].name ?? ""}  ${addressViewModel.addressCore?.address?[index].street ?? ""} ${addressViewModel.addressCore?.address?[index].area ?? ""} ',style: const TextStyle(
                                    //         fontFamily: AppFonts.cairoFontRegular, fontSize: 17.0),),
                                    //     leading: Radio(
                                    //       value: address_id,
                                    //       groupValue: address_id,
                                    //       onChanged: (value) {
                                    //         setState(() {
                                    //           print(value);
                                    //           address_id = value;
                                    //           print(address_id);
                                    //           // isSelected = true;
                                    //           // address_id = orderViewModel.addressCore?.address?[index].id ?? 0;
                                    //           // address_id = value;
                                    //           // print(address_id);
                                    //         });
                                    //       },
                                    //     ),
                                    //   ),
                                    // ),

                                    // Padding(
                                    //     padding: const EdgeInsets.only(top:80.0,right: 20.0),
                                    //     child: SelectableCircleWidget(
                                    //       deviceSize: deviceSize,
                                    //       isSelected: isSelected,
                                    //       title: '${addressViewModel.addressCore?.address?[index].name ?? ""} ${addressViewModel.addressCore?.address?[index].street ?? ""} ${addressViewModel.addressCore?.address?[index].area ?? ""}',
                                    //       onPressed: () {
                                    //         setState(() {
                                    //           isSelected = true;
                                    //           address_id = addressViewModel.addressCore?.address?[index].id ?? 0;
                                    //         });
                                    //       },
                                    //     ),
                                    //   ),
                                  ),
                                  SizedBox(
                                    height: deviceSize.height * 0.5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: MainButton(
                                      text: getTranslated(
                                          context, "order_review"),
                                      width: deviceSize.width * 0.9,
                                      onPressed: () {
                                        if (selectedIndex != null) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrderDetailsView(
                                                        address_id:
                                                            address_id ?? 0,
                                                        payment_type:
                                                            widget.payment_id,
                                                      )));
                                        } else {
                                          toastAppErr(
                                              "Order does not Saved Successfully ",
                                              contest: context);
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              )),
                  ),
                ],
              ),
            ),
    );
  }
}
