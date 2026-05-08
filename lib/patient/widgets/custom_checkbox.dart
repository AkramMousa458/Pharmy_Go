// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox(
      {super.key,
      required this.lable,
      required this.check,
      required this.active});

  final String lable;
  final bool check;
  final bool active;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Theme(
            data: ThemeData(
              checkboxTheme: CheckboxThemeData(
                fillColor: MaterialStateProperty.all(Colors.white),
                side: BorderSide(
                  color: MaterialStateColor.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return Colors.white; // selected border color
                    }
                    return widget.active
                        ? ThemeColors.kSecondColor(context)
                        : ThemeColors.kTextColor(
                            context); // default border color
                  }),
                ),
              ),
            ),
            child: Checkbox(
              activeColor: ThemeColors.kMainColor(context),
              value: widget.check,
              onChanged: (value) {
                value = widget.check;
                setState(() {});
              }, // Disable user interaction
            ),
          ),
          Text(
            widget.lable,
            style: TextStyle(
              fontSize: 18,
              color: widget.active == true
                  ? ThemeColors.kSecondColor(context)
                  : ThemeColors.kThirdTextColor(context),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
