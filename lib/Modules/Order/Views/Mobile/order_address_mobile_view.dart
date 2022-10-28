import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meem_app/Modules/Order/Views/order_details_view.dart';
import 'package:provider/provider.dart';

import '../../../../CommonWidget/main_button.dart';
import '../../../../CommonWidget/title_appbar.dart';
import '../../../../CommonWidget/toast.dart';
import '../../../../Constants/app_enums.dart';
import '../../../../Localization/app_localization.dart';
import '../../../Address/ViewModel/address_view_model.dart';
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(
                        addressViewModel.addressCore?.address?.length ??
                            0,
                            (index) => Padding(
                              padding: const EdgeInsets.only(top:80.0,right: 20.0),
                              child: SelectableCircleWidget(
                                deviceSize: deviceSize,
                                isSelected: isSelected,
                                title: '${addressViewModel.addressCore?.address?[index].name ?? ""} ${addressViewModel.addressCore?.address?[index].street ?? ""} ${addressViewModel.addressCore?.address?[index].area ?? ""}',
                                onPressed: () {
                                  setState(() {
                                    isSelected = true;
                                    address_id = addressViewModel.addressCore?.address?[index].id ?? 0;
                                  });
                                },
                              ),
                            ),),
                    SizedBox(
                      height: deviceSize.height * 0.5,
                    ),
                    MainButton(
                      text: getTranslated(context, "order_review"),
                      width: deviceSize.width * 0.9,
                      onPressed: () async{

                        bool result = await orderViewModel.placeOrder(address_id!, widget.payment_id, context);
                        if (result) {
                          toastAppSuccess(
                              "Place Order Successfully",
                              contest: context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailsView(address_id: address_id!, payment_type: widget.payment_id,) ));
                        } else {
                          toastAppErr(
                              "Order does not place Successfully ",
                              contest: context);
                        }

                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
