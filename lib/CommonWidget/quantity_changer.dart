import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';

class QuantityChanger extends StatefulWidget {
  final int qty;
  const QuantityChanger({Key? key, required this.qty}) : super(key: key);

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
              setState(() {
                if (_counter != 5)
                  {
                    _counter++;
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
              setState(() {
                if(_counter != 0){
                  _counter--;
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
