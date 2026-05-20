import 'package:flutter/material.dart';
import 'package:pharmygo/core/utils/assets.dart';

import '../../core/utils/colors.dart';

class GoogleButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor, textColor;
  final double width, height, borderRadius, textSize;
  final bool isBold;

  const GoogleButton({
    super.key, // Fixed the key parameter
    required this.onPressed,
    required this.text,
    this.backgroundColor = kSecondButtonColor,
    this.borderRadius = 32,
    this.textSize = 18,
    this.height = 50,
    this.width = double.infinity,
    this.textColor = kGreyColor,
    this.isBold = true,
  }); // Added super constructor with key parameter

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor,
        ),
        // margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Material(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: onPressed,
            child: Container(
              padding: const EdgeInsets.all(12), // Adjust padding as needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Assets.googleIcon),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: textSize,
                      color: textColor,
                      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
