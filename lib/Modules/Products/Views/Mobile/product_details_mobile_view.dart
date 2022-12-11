import 'package:flutter/material.dart';
import 'package:meem_app/CommonWidget/main_button.dart';
import 'package:meem_app/CommonWidget/quantity_changer.dart';
import 'package:meem_app/CommonWidget/search_appbar.dart';
import 'package:meem_app/Constants/app_assets.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Modules/Cart/ViewModel/add_to_cart_view_model.dart';
import 'package:meem_app/Modules/Products/Model/specfication_model.dart';
import 'package:meem_app/Modules/Products/ViewModel/product_detail_view_model.dart';
import 'package:meem_app/Modules/Products/ViewModel/product_favourite_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../CommonWidget/toast.dart';
import '../../../../Constants/app_enums.dart';
import '../../../Service Provider/Sp_Products/Model/specification_model.dart';

class ProductDetailsMobileView extends StatefulWidget {
  final int productId;
  String img;

  ProductDetailsMobileView(
      {Key? key, required this.productId, required this.img})
      : super(key: key);

  @override
  State<ProductDetailsMobileView> createState() =>
      _ProductDetailsMobileViewState();
}

class _ProductDetailsMobileViewState extends State<ProductDetailsMobileView> {
  late ProductsDetailsViewModel productsDetailsViewModel;
  int _counter = 1;
  bool isSelected = false;
  late AddToCartViewModel addToCartViewModel;
  late AddToFavouriteViewModel addToFavouriteViewModel;
  String? selectedValue;
  String? selectedSize = "";
  int? catId;
  List<int> selectedIndexes = [];
  List<int> _selectedValues = [];

  List<int> selectedSpecIndex = [];
  List<int> _selectedValuesIndex = [];

  @override
  void initState() {
    print("product id ${widget.productId}");
    addToCartViewModel =
        Provider.of<AddToCartViewModel>(context, listen: false);
    addToFavouriteViewModel =
        Provider.of<AddToFavouriteViewModel>(context, listen: false);
    productsDetailsViewModel =
        Provider.of<ProductsDetailsViewModel>(context, listen: false);
    Future(() async {
      await productsDetailsViewModel.ProductsDetailsFetchingData(
          context, widget.productId);
    });
    selectedIndexes = _selectedValues;
    selectedSpecIndex = _selectedValuesIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget SpecialValues(String? name, int? spec_id,int? id, bool isSelected, int index,
        List<ValuesModel>? values) {
      return InkWell(
        onTap: () {
          setState(() {
            // isSelected = !isSelected;
            values![index].isSelected = !values[index].isSelected;
            if (values[index].isSelected == true) {
              _selectedValues.add(id!);
              _selectedValuesIndex.add(spec_id!);
            } else if (values[index].isSelected == false) {
              _selectedValues.removeWhere((element) => element == id);
              _selectedValuesIndex.removeWhere((element) => element == spec_id);
            }
            print(_selectedValues);
            print(_selectedValuesIndex);
          });
        },
        child: Container(
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: isSelected ? AppColors.primary : Colors.grey[100]!,
              shape: BoxShape.rectangle),
          child: Center(
            child: Text(
              name!,
              style:  TextStyle(
                color: isSelected ? Colors.white : Colors.black ,
                  fontFamily: AppFonts.cairoFontRegular, fontSize: 15),
            ),
          ),
        ),
      );
    }

    productsDetailsViewModel =
        Provider.of<ProductsDetailsViewModel>(context, listen: true);
    addToCartViewModel = Provider.of<AddToCartViewModel>(context, listen: true);
    addToFavouriteViewModel =
        Provider.of<AddToFavouriteViewModel>(context, listen: true);
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: const SearchAppBar(),
        elevation: 0,
      ),
      body: productsDetailsViewModel.secondaryStatus == Status.loading ||
              productsDetailsViewModel.productDetailsCore == null ||
              addToFavouriteViewModel.status == Status.loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    alignment: setAlignmnetToCenterStart(context),
                    child: SelectableText(
                      productsDetailsViewModel
                              .productDetailsCore!.product!.name ??
                          "",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: AppFonts.cairoFontSemiBold, fontSize: 18),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child:
                            // Image.network(
                            //   AppAssets.testShoes,
                            // ),
                            Image.network(
                          widget.img,
                          width: deviceSize.width - 50,
                          height: deviceSize.height / 4,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 25,
                        child: IconButton(
                          icon: ImageIcon(
                            productsDetailsViewModel.productDetailsCore!
                                        .product!.isFavorite ==
                                    1
                                ? AssetImage(AppAssets.favRedFilled)
                                : AssetImage(AppAssets.favRedOutlined),
                            color: AppColors.favRed,
                            size: 28,
                          ),
                          onPressed: () async {
                            bool result =
                                await addToFavouriteViewModel.addToFav(
                                    productsDetailsViewModel
                                            .productDetailsCore!.product!.id ??
                                        0,
                                    context);

                            if (result) {
                              await productsDetailsViewModel
                                  .ProductsDetailsFetchingData(
                                      context, widget.productId);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 28, 20, 14),
                    alignment: setAlignmnetToCenterStart(context),
                    child: SelectableText(
                      getTranslated(context, "product_images"),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontFamily: AppFonts.cairoFontSemiBold,
                          fontSize: 15,
                          color: AppColors.grey162),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: setAlignmnetToCenterStart(context),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                            productsDetailsViewModel
                                .productDetailsCore!.product!.images!.length,
                            (index) => ProductImagesWidget(
                              selected: isSelected,
                              onPressed: () {
                                setState(() {
                                  isSelected = true;
                                  print(isSelected);
                                  widget.img = productsDetailsViewModel
                                          .productDetailsCore!
                                          .product!
                                          .images![index]
                                          .path ??
                                      "";
                                  print(widget.img);
                                });
                              },
                              img: productsDetailsViewModel.productDetailsCore!
                                      .product!.images![index].path ??
                                  "",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 28, 20, 12),
                    alignment: setAlignmnetToCenterStart(context),
                    child: SelectableText(
                      getTranslated(context, "store"),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontFamily: AppFonts.cairoFontSemiBold,
                          fontSize: 15,
                          height: 0.8,
                          color: AppColors.grey162),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: setAlignmnetToCenterStart(context),
                    child: SelectableText(
                      productsDetailsViewModel
                              .productDetailsCore!.product!.store ??
                          "",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: AppFonts.cairoFontSemiBold,
                          fontSize: 18,
                          color: AppColors.black),
                    ),
                  ),
                  ...List.generate(
                    productsDetailsViewModel
                        .productDetailsCore!.product!.specification!.length,
                    (item) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                          child: Text(
                            productsDetailsViewModel.productDetailsCore!
                                    .product!.specification![item].name ??
                                "",
                            style: const TextStyle(
                                fontFamily: AppFonts.cairoFontRegular,
                                fontSize: 20),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ...List.generate(productsDetailsViewModel.productDetailsCore!.product!.specification![item].values!.length, (val) =>
                                SpecialValues(
                                productsDetailsViewModel.productDetailsCore!.product!.specification?[item].values![val].value,
                                    productsDetailsViewModel.productDetailsCore!.product!.specification?[item].id,
                                productsDetailsViewModel.productDetailsCore!.product!.specification?[item].values![val].id,
                                productsDetailsViewModel.productDetailsCore!.product!.specification![item].values![val].isSelected,
                                0,
                                productsDetailsViewModel.productDetailsCore!.product!.specification?[item].values),),

                            SizedBox(height: 40),
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 28, 20, 12),
                    alignment: setAlignmnetToCenterStart(context),
                    child: SelectableText(
                      getTranslated(context, "product_description"),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontFamily: AppFonts.cairoFontSemiBold,
                          fontSize: 15,
                          height: 0.8,
                          color: AppColors.grey162),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: setAlignmnetToCenterStart(context),
                    child: SelectableText(
                      productsDetailsViewModel
                              .productDetailsCore!.product!.description ??
                          "",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: AppFonts.cairoFontSemiBold,
                          height: 1.35,
                          fontSize: 18,
                          color: AppColors.black),
                    ),
                  ),
                  Container(
                    alignment: setAlignmnetToCenterStart(context),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Text(
                      " ${productsDetailsViewModel.productDetailsCore!.product!.price ?? 0.0}  ر.س ",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: AppFonts.cairoFontBold, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  addToCartViewModel.status == Status.loading
                      ? const Center(child: CircularProgressIndicator())
                      : MainButton(
                          text: getTranslated(context, "go_to_cart"),
                          width: deviceSize.width - 40,
                          onPressed: () async {
                            bool result = await addToCartViewModel.addToCart(
                                widget.productId, selectedIndexes,selectedSpecIndex, context);

                            if (result) {
                              toastAppSuccess(
                                  "Product Added To cart Successfully",
                                  contest: context);
                            } else {
                              toastAppErr("Product does not add to cart",
                                  contest: context);
                            }
                          }),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
    );
  }
}

class ProductImagesWidget extends StatelessWidget {
  const ProductImagesWidget({
    Key? key,
    required this.selected,
    required this.onPressed,
    required this.img,
  }) : super(key: key);
  final String img;
  final bool selected;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border:
              selected ? Border.all(color: AppColors.primary, width: 2) : null,
          image: DecorationImage(
            image: NetworkImage(img),
          ),
        ),
      ),
    );
  }
}
