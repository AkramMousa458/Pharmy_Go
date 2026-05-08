// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';


class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox(
      {super.key,
      required this.text,
      required this.onChange,
      required this.check});

  final String text;
  final Function(bool?) onChange;
  final bool check;

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Theme(
          data: ThemeData(
            checkboxTheme: CheckboxThemeData(
              fillColor: MaterialStateProperty.all(Colors.white),
              side: const BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
          child: Radio(
            activeColor: ThemeColors.kSecondColor(context),
            value: widget.check,
            onChanged: widget.onChange,
            groupValue: true,
          ),
        ),
        Text(
          widget.text,
          style:  TextStyle(
            fontSize: 18,
            color: ThemeColors.kSecondColor(context),
          ),
        ),
      ],
    );
  }
}
