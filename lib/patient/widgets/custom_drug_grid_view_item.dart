import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/utils/icons.dart';
import 'package:pharmygo/patient/views/patient_drug_view.dart';
import 'package:pharmygo/public/models/drug_model.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class CustomDrugGridViewItem extends StatelessWidget {
  const CustomDrugGridViewItem({super.key, required this.drugModel});

  final DrugModel drugModel;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.pushNamed(context, PatientDrugView.routeName,
            arguments: drugModel);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: ThemeColors.kAppBarColor(context),
        ),
        child: Column(
          children: [
            Container(
              height: 100.h,
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ThemeColors.kAppBarColor(context),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    drugModel.imageUrl,
                    errorListener: (p0) => const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  drugModel.nameEn,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.kSecondColor(context),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // const Spacer(),
            Text(
              '${drugModel.price} LE',
              style: TextStyle(
                color: ThemeColors.kSecondColor(context),
                fontSize: 16.sp,
              ),
            ),
            // const Spacer(),
            const Divider(
              thickness: 0,
              height: 0,
              indent: 10,
              endIndent: 20,
            ),
            MaterialButton(
              onPressed: () {
                // showSnackBar(context, 'Added To Cart');
                Navigator.pushNamed(context, PatientDrugView.routeName,
                    arguments: drugModel);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Find Drug',
                      style: TextStyle(
                        color: ThemeColors.kMainColor(context),
                        fontSize: 14.sp,
                      ),
                    ),
                    FaIcon(
                      searchLocationIcon,
                      size: 20.sp,
                      color: ThemeColors.kMainColor(context),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
