import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class OptionList extends StatelessWidget {
  const OptionList({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });
  final String title;
  final FaIconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 82.5,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ThemeColors.kSecondBackgroundColor(context),
              ),
              child: FaIcon(
                icon,
                color: ThemeColors.kSecondColor(context),
                size: 40,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: TextStyle(
                  color: ThemeColors.kMainColor(context), fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
