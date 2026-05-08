import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/core/utils/icons.dart';

import 'package:pharmygo/core/helper/delete_alert_box.dart';
import 'package:pharmygo/public/models/drug_model.dart';

class CustomDeleteButton extends StatelessWidget {
  const CustomDeleteButton({super.key, required this.drugModel});
  final DrugModel drugModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        deleteAlertBox(context, drugModel: drugModel);
      },
      child: Container(
          width: Dimensions.screenWidth(context) / 3.5,
          height: Dimensions.screenHeight(context) / 8.5,
          decoration: BoxDecoration(
            color: ThemeColors.kAlarmColor(context),
            borderRadius: BorderRadius.circular(16),
          ),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    'Delete',
                    maxLines: 1,
                    style: TextStyle(
                      color: ThemeColors.kAppBarColor(context),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: FaIcon(
                  deleteIcon,
                  color: ThemeColors.kAppBarColor(context),
                  size: 25,
                ),
              ),
            ],
          )),
    );
  }
}
