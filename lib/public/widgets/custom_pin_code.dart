import 'package:flutter/material.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinCode extends StatelessWidget {
  const CustomPinCode({super.key});

  @override
  Widget build(BuildContext context) {
    final pinTheme = MaterialPinTheme(
      shape: MaterialPinShape.outlined,
      cellSize: const Size(70, 70),
      spacing: 12,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      borderWidth: 2,
      focusedBorderWidth: 2.5,
      borderColor: ThemeColors.kGreyColor(context),
      focusedBorderColor: ThemeColors.kSecondColor(context),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Theme(
        data: Theme.of(context).copyWith(
          extensions: [
            MaterialPinThemeExtension(theme: pinTheme),
          ],
        ),
        child: MaterialPinField(
          length: 4,
          keyboardType: TextInputType.number,
          onChanged: (value) {},
        ),
      ),
    );
  }
}