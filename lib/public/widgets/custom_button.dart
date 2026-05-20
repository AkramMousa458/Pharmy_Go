import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/core/utils/colors.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor, textColor;
  final double width, height, borderRadius, textSize;
  final bool isBold, isLoading;

  const CustomButton({
    super.key, // Fixed the key parameter
    required this.onPressed,
    required this.text,
    this.backgroundColor = kMainButtonColor,
    this.borderRadius = 32,
    this.textSize = 20,
    this.height = 50,
    this.width = double.infinity,
    this.textColor = kTextColor,
    this.isBold = false,
    this.isLoading = false,
  }); // Added super ructor with key parameter

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
        // margin:  EdgeInsets.symmetric(horizontal: 25),
        child: Material(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: onPressed,
            child: Container(
              padding: const EdgeInsets.all(10), // Adjust padding as needed
              child: Center(
                child: isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 22.w,
                            height: 20.h,
                            child: Center(
                              child: CustomLoadingIndicator(
                                color: textColor,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            text,
                            style: TextStyle(
                                fontSize: textSize,
                                color: textColor,
                                fontWeight: isBold
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ],
                      )
                    : Text(
                        text,
                        style: TextStyle(
                            fontSize: textSize,
                            color: textColor,
                            fontWeight:
                                isBold ? FontWeight.bold : FontWeight.normal),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
