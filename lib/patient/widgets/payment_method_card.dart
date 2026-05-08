import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    super.key,
    required this.iconData,
    this.isSelected = false,
    required this.onTap,
  });

  final FaIconData iconData;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.75,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              color: isSelected == false
                  ? ThemeColors.kTextColor(context)
                  : ThemeColors.kMainColor(context),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: FaIcon(
                iconData,
                size: 50,
                color: isSelected == false
                    ? ThemeColors.kMainColor(context)
                    : ThemeColors.kTextColor(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
