import 'package:flutter/material.dart';

class CustomShimmerChild extends StatelessWidget {
  const CustomShimmerChild({
    super.key,
    this.width,
    this.height,
  });
  final double? width, height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
