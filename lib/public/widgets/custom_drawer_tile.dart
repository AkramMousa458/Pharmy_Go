import 'package:flutter/material.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class CustomDrawerTile extends StatelessWidget {
  final double fontSize = 14;
  final double iconSize = 20;
  const CustomDrawerTile(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.title});
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Icon(
            icon,
            color: ThemeColors.kSecondColor(context),
            size: iconSize,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ThemeColors.kSecondColor(context),
              fontSize: fontSize,
            ),
          ),
        ),
        const Divider(
          endIndent: 20,
          indent: 30,
        ),
      ],
    );
  }
}
