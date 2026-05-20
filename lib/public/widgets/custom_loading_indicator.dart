import 'package:flutter/material.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    super.key,
    this.width = 28.0,
    this.height = 28.0,
    this.strokeWidth = 2.0,
    this.color,
  });

  final double width;
  final double height;
  final double strokeWidth;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator(
        color: color ?? ThemeColors.kMainColor(context),
        strokeWidth: strokeWidth,
      ),
    );
  }
}
