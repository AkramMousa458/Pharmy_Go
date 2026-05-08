import 'package:flutter/material.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/core/utils/dimensions.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key, required this.text, required this.action});
  final String text;
  final VoidCallback action;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimensions.screenWidth(context) / 2.8,
      child: ElevatedButton(
          onPressed: action,
          style: ElevatedButton.styleFrom(
            backgroundColor: ThemeColors.kAlarmColor(context), // Border color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  10.0), // Adjust the border radius as needed
            ),
          ),
          child: Text(
            text,
            style:  TextStyle(
              color: ThemeColors.kTextColor(context),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}
