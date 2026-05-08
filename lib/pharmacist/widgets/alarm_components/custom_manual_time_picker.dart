import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/core/utils/dimensions.dart';

class NumbersPage extends StatefulWidget {
  const NumbersPage({super.key});

  @override
  State<NumbersPage> createState() => _NumbersPageState();
}

class _NumbersPageState extends State<NumbersPage> {
  var hour = 0;
  var minute = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.screenWidth(context) / 1.2,
      height: Dimensions.screenHeight(context) / 2.5,
      padding: const EdgeInsets.only(bottom: 20, top: 20, right: 10, left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NumberPicker(
            minValue: 0,
            maxValue: 12,
            value: hour,
            zeroPad: true,
            infiniteLoop: true,
            itemWidth: Dimensions.screenWidth(context) / 4,
            itemHeight: Dimensions.screenHeight(context) / 10.1,
            onChanged: (value) {
              setState(() {
                hour = value;
              });
            },
            textStyle: TextStyle(
              color: ThemeColors.kThirdTextColor(context),
              fontSize: 20,
            ),
            selectedTextStyle: TextStyle(
              color: ThemeColors.kSecondColor(context),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(color: ThemeColors.kSecondColor(context)),
              bottom: BorderSide(color: ThemeColors.kSecondColor(context)),
            )),
          ),
          NumberPicker(
            minValue: 0,
            maxValue: 59,
            value: minute,
            zeroPad: true,
            infiniteLoop: true,
            itemWidth: Dimensions.screenWidth(context) / 4,
            itemHeight: Dimensions.screenHeight(context) / 10.1,
            onChanged: (value) {
              setState(() {
                minute = value;
              });
            },
            textStyle: TextStyle(
              color: ThemeColors.kThirdTextColor(context),
              fontSize: 20,
            ),
            selectedTextStyle: TextStyle(
              color: ThemeColors.kSecondColor(context),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(color: ThemeColors.kSecondColor(context)),
              bottom: BorderSide(color: ThemeColors.kSecondColor(context)),
            )),
          )
        ],
      ),
    );
  }
}
