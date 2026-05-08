import 'package:flutter/material.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/core/utils/dimensions.dart';

class CustomOutLinedtButton extends StatelessWidget {
  const CustomOutLinedtButton(
      {super.key, required this.text, required this.action});
  final String text;
  final VoidCallback action;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimensions.screenWidth(context) / 4,
      child: OutlinedButton(
        onPressed: action,
        style: OutlinedButton.styleFrom(
          side:  BorderSide(
              color: ThemeColors.kAlarmColor(context)), // Border color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                10.0), // Adjust the border radius as needed
          ),
        ),
        child: Text(
          text,
          style:  TextStyle(
            color: ThemeColors.kAlarmColor(context),
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
