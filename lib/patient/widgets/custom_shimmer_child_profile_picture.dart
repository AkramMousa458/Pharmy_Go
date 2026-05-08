import 'package:flutter/material.dart';
import 'package:pharmygo/core/utils/dimensions.dart';

class CustomShimmerChildProfilePicture extends StatelessWidget {
  const CustomShimmerChildProfilePicture({
    super.key,
    this.width,
    this.height,
    this.radius,
  });
  final double? width, height;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? Dimensions.screenWidth(context) / 4.8,
      backgroundColor: Colors.black.withOpacity(0.04),
    );
  }
}
