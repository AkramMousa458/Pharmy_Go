

import 'package:flutter/material.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28.0,
      height: 28.0,
      child: CircularProgressIndicator(
        color: ThemeColors.kMainColor(context),
        strokeWidth: 2.0,
      ),
    );
  }
}
