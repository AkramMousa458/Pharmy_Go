import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/public/models/shortage_drug_model.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';

class ShortageDrugItem extends StatelessWidget {
  const ShortageDrugItem({
    super.key,
    required this.shortageDrugModel,
  });
  final ShortageDrugModel shortageDrugModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      height: Dimensions.screenHeight(context) / 8,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ThemeColors.kSecondBackgroundColor(context),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: CachedNetworkImage(
              imageUrl: shortageDrugModel.drug.imageUrl,
              fit: BoxFit.cover,
              height: Dimensions.screenWidth(context) / 2.6,
              width: Dimensions.screenWidth(context) / 4,
              placeholder: (context, url) =>
                  const Center(child: CustomLoadingIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: SizedBox(
              height: 55.h,
              width: 160.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shortageDrugModel.drug.nameEn,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 15,
                      color: ThemeColors.kSecondColor(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Shortage Quantity: ${shortageDrugModel.quantity}',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: ThemeColors.kAlarmColor(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
