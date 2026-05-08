import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/utils/colors.dart';

class CustomCircleButton extends StatelessWidget {
  const CustomCircleButton({
    super.key,
    required this.iconData,
    this.backgroundColor = kMainColor,
    this.iconColor = kTextColor,
    this.iconSize = 12,
    this.onPressed,
  });

  final FaIconData iconData;
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      iconSize: iconSize,
      onPressed: onPressed,
      icon: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        child: FaIcon(
          iconData,
          color: iconColor,
        ),
      ),
    );
  }
}
