import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
class CustomShimmer extends StatelessWidget {
  const CustomShimmer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black,
      highlightColor: ThemeColors.kSecondBackgroundColor(context),
      child: child,
    );
  }
}
