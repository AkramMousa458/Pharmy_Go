import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_image_viewer/gallery_image_viewer.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/pharmacist/models/custom_order_model.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';

class PharmacyDrugOrderItem extends StatelessWidget {
  const PharmacyDrugOrderItem({
    super.key,
    required this.customOrderModel,
  });

  final CustomOrderModel customOrderModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              showImageViewer(context,
                  NetworkImage(customOrderModel.items[0].drug.imageUrl),
                  swipeDismissible: false);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: CachedNetworkImage(
                imageUrl: customOrderModel.items[0].drug.imageUrl,
                fit: BoxFit.cover,
                height: 90.h,
                width: 90.w,
                placeholder: (context, url) =>
                    const Center(child: CustomLoadingIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customOrderModel.items[0].drug.nameEn,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: ThemeColors.kSecondColor(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Quantity:  ',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: ThemeColors.kGreyColor(context),
                        ),
                      ),
                      Text(
                        customOrderModel.items[0].quantity.toString(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: ThemeColors.kSecondColor(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
