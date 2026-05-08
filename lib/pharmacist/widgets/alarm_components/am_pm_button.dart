import 'package:flutter/material.dart';

import 'package:pharmygo/core/theme/theme_colors.dart';
class AmPmSwitch extends StatefulWidget {
  const AmPmSwitch({super.key});

  @override
  State<AmPmSwitch> createState() => _AmPmSwitchState();
}

class _AmPmSwitchState extends State<AmPmSwitch> {
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = [true, false]; // Set initial selection
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ToggleButtons(
          color: ThemeColors.kMainColor(context).withOpacity(0.60),
          selectedColor: ThemeColors.kMainColor(context),
          selectedBorderColor: ThemeColors.kMainColor(context),
          fillColor: ThemeColors.kMainColor(context).withOpacity(0.08),
          splashColor: ThemeColors.kMainColor(context).withOpacity(0.12),
          hoverColor: ThemeColors.kMainColor(context).withOpacity(0.04),
          borderRadius: BorderRadius.circular(10.0),
          constraints: const BoxConstraints(minHeight: 36.0),
          isSelected: isSelected,
          onPressed: (index) {
            // Respond to button selection
            setState(() {
              for (int i = 0; i < isSelected.length; i++) {
                isSelected[i] = i == index;
              }
            });
          },
          children:  [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'AM',
                style: TextStyle(
                  fontSize: 25,
                  color: ThemeColors.kMainColor(context),
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'PM',
                style: TextStyle(
                  fontSize: 25,
                  color: ThemeColors.kMainColor(context),
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
