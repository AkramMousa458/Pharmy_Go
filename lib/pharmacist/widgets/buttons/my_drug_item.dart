import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/pharmacist/widgets/buttons/custom_delete_button.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/public/models/drug_model.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';

class MyDrugItem extends StatelessWidget {
  const MyDrugItem({
    super.key,
    required this.drugModel,
  });
  final DrugModel drugModel;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        extentRatio: 0.35,
        children: [
          Flexible(child: CustomDeleteButton(drugModel: drugModel)),
        ],
      ),
      child: Container(
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
                imageUrl: drugModel.imageUrl,
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
                height: 40,
                width: Dimensions.screenWidth(context) / 2.4,
                child: Text(
                  drugModel.nameEn,
                  style: TextStyle(
                    fontSize: 15,
                    color: ThemeColors.kSecondColor(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
