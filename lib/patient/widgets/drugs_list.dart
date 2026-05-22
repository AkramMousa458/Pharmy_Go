import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pharmygo/core/utils/colors.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/public/models/drug_model.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';

class DrugsList extends StatelessWidget {
  const DrugsList({
    super.key,
    required this.drugModel,
    required this.onTap,
  });

  final DrugModel drugModel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 14 ),
        child: Container(
          height: 180,
          width: 150,
          decoration: BoxDecoration(
            color: ThemeColors.kSecondBackgroundColor(context),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: CachedNetworkImage(
                  imageUrl: drugModel.imageUrl,
                  fit: BoxFit.cover,
                  height: Dimensions.screenWidth(context) / 2.6,
                  width: Dimensions.screenWidth(context) / 3,
                  placeholder: (context, url) =>
                      const Center(child: CustomLoadingIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  drugModel.nameEn,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 18,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Text(
                "${drugModel.price.toString()} EGP",
                style: const TextStyle(fontSize: 18, color: kSecondColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
