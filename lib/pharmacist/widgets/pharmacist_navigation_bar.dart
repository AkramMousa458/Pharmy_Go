import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/core/utils/icons.dart';
import 'package:pharmygo/public/widgets/custom_navigation_bar.dart';

class PharmacistNavigationBar extends StatelessWidget {
  const PharmacistNavigationBar({super.key});
  final double iconSize = 22;
  @override
  Widget build(BuildContext context) {
    return CustomNavigationBar(
      items: [
        FaIcon(
          homeIcon,
          size: iconSize,
          color: ThemeColors.kSecondColor(context),
        ),
        FaIcon(
          profileIcon,
          size: iconSize,
          color: ThemeColors.kSecondColor(context),
        ),
        FaIcon(
          drugsIcon,
          size: iconSize,
          color: ThemeColors.kSecondColor(context),
        ),
      ],
    );
  }
}
