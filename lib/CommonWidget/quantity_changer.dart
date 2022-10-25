import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';

import '../Modules/Cart/ViewModel/cart_view_model.dart';
import '../Modules/Cart/ViewModel/update_cart_view_model.dart';

class QuantityChanger extends StatefulWidget {
  late int qty;
  late int id;

  late UpdateCartViewModel updateCartViewModel;
  late CartViewModel cartViewModel;
   QuantityChanger({Key? key, required this.qty, required this.id , required this.cartViewModel, required this.updateCartViewModel}) : super(key: key);

  @override
  State<QuantityChanger> createState() => _QuantityChangerState();
}

class _QuantityChangerState extends State<QuantityChanger> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Container(

          // decoration: BoxDecoration(
          //     border: Border.all(
          //       color: AppColors.primary,
          //       width: 2.5,
          //     ),
          //     borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            color: AppColors.primary,
            icon: Icon(
              Icons.add,
              size: 26,
            ),
            onPressed: () {
              setState(() async{
                if (widget.qty != 5)
                  {
                    widget.qty++;
                    bool result = await widget.updateCartViewModel.updateCart(widget.qty, widget.id, context);
                    if (result){
                      await widget.cartViewModel
                          .cartFetchingData(context);
                    }
                  }


              });
            },
          ),
        ),
        const Spacer(),
         Text(
         "${widget.qty}",
          style: TextStyle(
            color: AppColors.black,
            fontFamily: AppFonts.cairoFontSemiBold,
            fontSize: 20,
          ),
        ),
        const Spacer(),
        Container(
          // decoration: BoxDecoration(
          //     border: Border.all(
          //       color: AppColors.primary,
          //       width: 2.5,
          //     ),
          //     borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            color: AppColors.primary,
            icon: Icon(
              Icons.remove,
              size: 26,
            ),
            onPressed: () {
              setState(() async{
                if(widget.qty != 0){
                  widget.qty--;
                  bool result = await widget.updateCartViewModel.updateCart(widget.qty, widget.id, context);
                  if (result){
                    await widget.cartViewModel
                        .cartFetchingData(context);
                  }
                }

              });
            },
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
