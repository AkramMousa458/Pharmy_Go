import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/core/utils/colors.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/public/models/order_model.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';

import '../../core/theme/theme_colors.dart';

class CustomOrderInfo extends StatelessWidget {
  const CustomOrderInfo({
    super.key,
    required this.orderModel,
  });

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: CachedNetworkImage(
              imageUrl: orderModel.items[0].drug.imageUrl,
              fit: BoxFit.cover,
              height: Dimensions.screenWidth(context) / 4,
              width: Dimensions.screenWidth(context) / 4,
              placeholder: (context, url) =>
                  const Center(child: CustomLoadingIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: Dimensions.screenWidth(context) / 2.3,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4, left: 10),
                  child: Text(
                    orderModel.items[0].drug.nameEn,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 14.sp,
                      overflow: TextOverflow.ellipsis,
                      color: ThemeColors.kSecondColor(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  'Price: ${orderModel.totalAmount} LE',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: kMainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
