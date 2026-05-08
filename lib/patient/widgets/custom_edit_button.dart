import 'package:flutter/material.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class CustomEditButton extends StatelessWidget {
  const CustomEditButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      minWidth: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style:  TextStyle(
          fontSize: 14,
          color: ThemeColors.kGreyColor(context),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
