import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.onChange,
      this.hintText,
      this.startIcon,
      this.endIcon,
      this.inputColor = Colors.black,
      this.hintColor,
      this.isPassword = false,
      this.onSubmitted,
      this.borderRadius = 15,
      this.label,
      this.validator,
      this.width = 300,
      this.controller,
      this.endIconSize,
      this.startIconSize,
      this.isNumber = false,
      this.isEnabled = true,
      this.onTapEndIcon,
      this.onTap});
  final String? hintText, label;
  final FaIconData? startIcon, endIcon;
  final Color? inputColor, hintColor;
  final bool isPassword, isNumber, isEnabled;
  final Function(String)? onChange, onSubmitted;
  final void Function()? onTap, onTapEndIcon;
  final TextEditingController? controller;
  final double width, borderRadius;
  final double? endIconSize, startIconSize;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
          enabled: isEnabled,
          obscureText: isPassword,
          enableSuggestions: !isPassword,
          autocorrect: !isPassword,
          controller: controller ?? TextEditingController(),
          onFieldSubmitted: onSubmitted,
          validator: validator ??
              (value) {
                if (value!.isEmpty) {
                  return "This field is required";
                }
                return null;
              },
          onChanged: onChange,
          onTap: onTap,
          keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
          style: TextStyle(
            color: inputColor,
            fontSize: 20,
          ),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ThemeColors.kMainColor(context)),
                borderRadius: BorderRadius.circular(borderRadius)),
            hintStyle: TextStyle(color: hintColor ?? Colors.grey, fontSize: 20),
            fillColor: Colors.transparent,
            filled: true,
            suffixIcon: IconButton(
              onPressed: onTapEndIcon,
              icon: FaIcon(
                endIcon,
                size: endIconSize,
              ),
              color: ThemeColors.kSecondColor(context),
            ),
            prefixIcon: IconButton(
              onPressed: onTap,
              icon: FaIcon(
                startIcon,
                size: startIconSize,
              ),
              color: ThemeColors.kSecondColor(context),
            ),
            contentPadding: const EdgeInsets.only(left: 10, top: 20),
            label: label != null ? Text(label!) : null,
            hintText: hintText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
          )),
    );
  }
}
