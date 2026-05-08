import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/public/widgets/custom_shimer.dart';
import 'package:pharmygo/public/widgets/custom_shimmer_child.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
class ShimmerHomePagePatient extends StatelessWidget {
  const ShimmerHomePagePatient({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        height: 240,
        width: 170,
        decoration: BoxDecoration(
          color: ThemeColors.kSecondBackgroundColor(context),
          borderRadius: BorderRadius.circular(25),
        ),
        child: CustomShimmer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomShimmerChild(
                  height: Dimensions.screenWidth(context) / 2.6,
                  width: double.infinity,
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomShimmerChild(
                  width: 140.w,
                  height: 15.h,
                ),
                const SizedBox(
                  height: 6,
                ),
                const CustomShimmerChild(
                  width: 130,
                  height: 15,
                ),
                const SizedBox(
                  height: 6,
                ),
                const CustomShimmerChild(
                  width: 110,
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
