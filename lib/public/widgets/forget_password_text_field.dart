import 'package:flutter/material.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class ForgetPasswordTextField extends StatelessWidget {
  const ForgetPasswordTextField({
    super.key,
    this.hintText = "",
    required this.onChanged,
    this.isPassword = false,
    this.isNumber = false,
  });
  final String hintText;
  final Function(String) onChanged;
  final bool isPassword;
  final bool isNumber;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      obscureText: isPassword,
      keyboardType:
          isNumber ? TextInputType.phone : TextInputType.visiblePassword,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.white,
        hintStyle:  TextStyle(color: ThemeColors.kGreyColor(context)),
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
