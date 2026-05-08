import 'package:flutter/material.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/patient/widgets/custom_shimmer_child_profile_picture.dart';
import 'package:pharmygo/public/widgets/custom_shimer.dart';
import 'package:pharmygo/public/widgets/custom_shimmer_child.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
class ShimmerProfilePatient extends StatelessWidget {
  const ShimmerProfilePatient({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        height: 600,
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
                const CustomShimmerChildProfilePicture(),
                const SizedBox(
                  height: 15,
                ),
                CustomShimmerChild(
                    width: Dimensions.screenWidth(context) * 0.70,
                    height: Dimensions.screenHeight(context) / 25),
                const SizedBox(
                  height: 15,
                ),
                CustomShimmerChild(
                    width: Dimensions.screenWidth(context) * 0.70,
                    height: Dimensions.screenHeight(context) / 25),
                const SizedBox(
                  height: 15,
                ),
                CustomShimmerChild(
                  width: Dimensions.screenWidth(context) * 0.80,
                  height: Dimensions.screenHeight(context) * 0.078,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomShimmerChild(
                  width: Dimensions.screenWidth(context) * 0.80,
                  height: Dimensions.screenHeight(context) * 0.078,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomShimmerChild(
                  width: Dimensions.screenWidth(context) * 0.80,
                  height: Dimensions.screenHeight(context) * 0.078,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
