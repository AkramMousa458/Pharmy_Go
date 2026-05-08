import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/core/utils/icons.dart';
import 'package:pharmygo/pharmacist/widgets/delete_medcine_bottom_sheet.dart';
import 'package:pharmygo/pharmacist/widgets/edit_quantity_medcine_bottom_sheet.dart';
import 'package:pharmygo/public/models/drug_model.dart';
import 'package:pharmygo/public/widgets/custom_circle_button.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';

// ignore: must_be_immutable
class AddButton extends StatelessWidget {
  final DrugModel drugModel;
  final VoidCallback onPressed;
  bool isAdded;

  AddButton({
    required this.drugModel,
    required this.onPressed,
    required this.isAdded,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        height: Dimensions.screenHeight(context) / 7.6,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ThemeColors.kSecondBackgroundColor(context),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: CachedNetworkImage(
                imageUrl: drugModel.imageUrl,
                fit: BoxFit.fill,
                height: Dimensions.screenWidth(context) / 2.6,
                width: Dimensions.screenWidth(context) / 4,
                placeholder: (context, url) =>
                    const Center(child: CustomLoadingIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(
              width: 6,
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
            Visibility(
              visible: !isAdded, // Show the button if not added
              child: CustomCircleButton(
                iconData: plusIcon,
                backgroundColor: ThemeColors.kMainColor(context),
                iconColor: ThemeColors.kBackgroundColor(context),
                iconSize: 16,
                onPressed: onPressed,
              ),
            ),
            Visibility(
                visible: isAdded, // Show the "Added" text if added
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        editQuantityDrugBottomSheet(
                            context: context,
                            title: "Edit Quantity",
                            drugModel: drugModel);
                      },
                      icon: const Icon(Icons.edit),
                      color: ThemeColors.kMainColor(context),
                    ),
                    IconButton(
                      onPressed: () {
                        deleteMedcineBottomSheet(
                          drugModel: drugModel,
                            context: context, title: "Are You Sure");
                      },
                      icon: const FaIcon(FontAwesomeIcons.trashCan),
                      color: ThemeColors.kAlarmColor(context),
                    ),
                  ],
                )
                //  Text(
                //   'Added',
                //   style: TextStyle(
                //     fontSize: 15,
                //     color: ThemeColors.kMainColor(context),
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                ),
          ],
        ));
  }
}
