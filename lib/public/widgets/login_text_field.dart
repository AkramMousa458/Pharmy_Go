import 'package:flutter/material.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.iconSuffix,
    this.isPassword = false,
    this.isNumber = false,
    this.validator,
    this.isEnabled = true,
  });

  final String hintText;
  final Function(String) onChanged;
  final Widget? iconSuffix;
  final bool isPassword;
  final bool isNumber;
  final String? Function(String?)? validator;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
      height: ScreenUtil().setHeight(56), // Set the height of the TextField
      child: TextFormField(
        enabled: isEnabled,
        validator: validator ??
            (value) {
              if (value!.isEmpty) {
                return "This field is required";
              }
              return null;
            },
        onChanged: onChanged,
        obscureText: isPassword,
        keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: iconSuffix,
          suffixIconConstraints:
              const BoxConstraints(minWidth: 44, minHeight: 44),
          suffixIconColor: ThemeColors.kSecondColor(context),
          fillColor: Colors.white,
          hintStyle: TextStyle(
            color: ThemeColors.kSecondColor(context),
            fontSize: 14.sp, // Set the font size for the hintText
          ),
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 18.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(15)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
