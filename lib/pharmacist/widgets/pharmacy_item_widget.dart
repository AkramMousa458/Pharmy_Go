import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/core/utils/icons.dart';
import 'package:pharmygo/pharmacist/models/nearst_pharmacy_model.dart';
import 'package:pharmygo/public/models/drug_model.dart';
import 'package:pharmygo/public/views/map/find_pharmacy_on_map_with_drug.dart';
import 'package:pharmygo/public/widgets/custom_circle_button.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class PharmacyItemWidget extends StatelessWidget {
  const PharmacyItemWidget({
    super.key,
    required this.nearestPharmacyModel,
    required this.drugModel,
  });

  final NearestPharmacyModel nearestPharmacyModel;
  final DrugModel drugModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: MaterialButton(
        onPressed: () {
          Navigator.pushNamed(context, FindPharmacyOnMapWithDrug.routeName,
              arguments: {
                'nearesrPharmacy': nearestPharmacyModel,
                'drugModel': drugModel
              });
        },
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              nearestPharmacyModel.pharmacyName,
              style: TextStyle(
                fontSize: 24.sp,
                color: ThemeColors.kSecondColor(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomCircleButton(
              iconData: locationIcon,
              backgroundColor: ThemeColors.kMainColor(context),
              iconColor: ThemeColors.kBackgroundColor(context),
              iconSize: 22.sp,
              onPressed: () {
                Navigator.pushNamed(
                    context, FindPharmacyOnMapWithDrug.routeName, arguments: {
                  'nearesrPharmacy': nearestPharmacyModel,
                  'drugModel': drugModel
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
