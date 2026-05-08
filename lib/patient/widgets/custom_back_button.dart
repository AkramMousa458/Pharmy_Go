import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/core/utils/icons.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon:  FaIcon(
        backIcon,
        color: ThemeColors.kSecondColor(context),
        size: 30,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
