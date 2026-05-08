import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/core/utils/dimensions.dart';

class DataShow extends StatelessWidget {
  const DataShow({
    super.key,
    required this.data,
    required this.icon,
  });
  final String data;
  final FaIconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        alignment: Alignment.centerLeft,
        width: Dimensions.screenWidth(context) * 0.80,
        height: 45.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(88, 158, 158, 158),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Row(
            children: [
              FaIcon(
                icon,
                color: ThemeColors.kSecondColor(context),
                // size: 25,
                size: Dimensions.screenWidth(context) * 0.06,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, left: 8),
                  child: Text(
                    data,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: Dimensions.screenWidth(context) / 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
