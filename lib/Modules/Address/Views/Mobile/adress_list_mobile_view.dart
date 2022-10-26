import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Modules/Address/ViewModel/address_view_model.dart';
import 'package:meem_app/Modules/Address/Views/add_address_view.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../CommonWidget/title_appbar.dart';
import '../../../../Constants/app_enums.dart';
import '../../../../Constants/app_fonts.dart';
import '../../../../Localization/app_localization.dart';
import '../../../Authentication/authentication_view_model.dart';

class AddressListMobileView extends StatefulWidget {
  static String id = "addressScreen";

  const AddressListMobileView({Key? key}) : super(key: key);

  @override
  State<AddressListMobileView> createState() => _AddressListMobileViewState();
}

class _AddressListMobileViewState extends State<AddressListMobileView> {
  bool isVisible1 = false;
  late AddressViewModel addressViewModel;
  late AuthenticationViewModel authViewModel;

  @override
  void initState() {
    // TODO: implement initState
    addressViewModel = Provider.of<AddressViewModel>(context, listen: false);
    authViewModel = Provider.of<AuthenticationViewModel>(context, listen: false);

    Future(() async {
      await addressViewModel.addressFetchingData(context);
      await authViewModel.spGetListData(context);
    });

    callThisMethod(isVisible1);
    super.initState();
  }

  void callThisMethod(bool isVisible) {
    debugPrint('_AddressScreen.callThisMethod: isVisible: ${isVisible}');
    // if (isVisible) {
    //   listFavouriteViewModel.FavouriteFetchingData(context);
    // }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    addressViewModel = Provider.of<AddressViewModel>(context, listen: true);
    return VisibilityDetector(
      key: Key(AddressListMobileView.id),
      onVisibilityChanged: (VisibilityInfo info) {
        bool isVisible = info.visibleFraction != 0;
        callThisMethod(isVisible);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: TitleAppBar(
            title: getTranslated(context, "my_addresses"),
            buttonTitle: getTranslated(context, "new_Address"),
            onPrssed: () {
              print("pressed");
              // print(AddProductView.routeName);
              // Navigator.of(context).pushNamed(AddProductView.routeName);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddAddressView()
                  ));
            },
          ),
          elevation: 0,
        ),
        body: addressViewModel.secondaryStatus == Status.loading ||
                addressViewModel.addressCore == null || authViewModel.secondaryStatus == Status.loading
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
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blueGrey, width: 0.4),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  5.0) //                 <--- border radius here
                                              ),
                                        ),
                                        height: deviceSize.height * 0.25,
                                        width: deviceSize.width,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(addressViewModel.addressCore?.address?[index].name ?? "",style: const TextStyle(
                                              fontFamily: AppFonts.cairoFontRegular, fontSize: 16),),
                                                  SizedBox(width: 20,),
                                                  TextButton(onPressed: (){}, child: Text(getTranslated(context, "edit"),style: const TextStyle(
                                                      fontFamily: AppFonts.cairoFontRegular, fontSize: 20, color: AppColors.primary),)),
                                                  TextButton(onPressed: (){}, child: Text(getTranslated(context, "delete_btn"),style: const TextStyle(
                                                      fontFamily: AppFonts.cairoFontRegular, fontSize: 20, color: AppColors.searchBarClearRed),)),

                                                ],
                                              ),
                                              Text(addressViewModel.addressCore?.address?[index].city ?? "",style: const TextStyle(
                                                  fontFamily: AppFonts.cairoFontRegular, fontSize: 16),),
                                              Text(addressViewModel.addressCore?.address?[index].area ?? "",style: const TextStyle(
                                                  fontFamily: AppFonts.cairoFontRegular, fontSize: 16),),
                                              SizedBox(
                                                child: Text(addressViewModel.addressCore?.address?[index].specificSign ?? "",style: const TextStyle(
                                                    fontFamily: AppFonts.cairoFontRegular, fontSize: 16),),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text( "السعودية",style: const TextStyle(
                                                      fontFamily: AppFonts.cairoFontBold, fontSize: 18),),
                                                  Text( addressViewModel.addressCore?.address?[index].isPrimary == 1 ? "(الافتراضي)" : "",style: const TextStyle(
                                                      fontFamily: AppFonts.cairoFontBold, fontSize: 18),),
                                                ],
                                              )

                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                            // Container(
                            //   height: deviceSize.height * 0.7,
                            //   child:
                            //   GridView.builder(
                            //       itemCount: addressViewModel.addressCore?.address?.length ?? 0,
                            //       scrollDirection: Axis.vertical,
                            //       gridDelegate:
                            //       SliverGridDelegateWithFixedCrossAxisCount(
                            //         childAspectRatio: 100 / 176,
                            //         crossAxisCount: 2,
                            //       ),
                            //       itemBuilder: (context, index) {
                            //         return Padding(
                            //             padding: const EdgeInsets.all(8.0),
                            //             child:  Container(
                            //
                            //               color: Colors.blueGrey,
                            //
                            //             )
                            //         );
                            //       }),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
