import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmygo/core/utils/colors.dart';
import 'package:pharmygo/public/cubits/switch_cubit/switch_cubit.dart';

class ThemeColors {
  static Color kBackgroundColor(BuildContext context) =>
      context.read<SwitchCubit>().isLightMode
          ? kLightBackgroundColor
          : kDarkBackgroundColor;
  static Color kSecondBackgroundColor(BuildContext context) =>
      context.read<SwitchCubit>().isLightMode
          ? kLightSecondBackgroundColor
          : kDarkSecondBackgroundColor;
  static Color kMainColor(BuildContext context) =>
      context.read<SwitchCubit>().isLightMode
          ? kLightMainColor
          : kDarkMainColor;

  static Color kSecondColor(BuildContext context) =>
      context.read<SwitchCubit>().isLightMode
          ? kLightSecondColor
          : kDarkSecondColor;

  // Stop here
  static Color kThirdTextColor(BuildContext context) =>
      context.read<SwitchCubit>().isLightMode
          ? kLightThirdTextColor
          : kDarkThirdTextColor;
  static Color kSecondButtonColor(BuildContext context) =>
      context.read<SwitchCubit>().isLightMode
          ? kLightSecondButtonColor
          : kDarkSecondButtonColor;
  static Color kLightGreyColor(BuildContext context) =>
      context.read<SwitchCubit>().isLightMode
          ? kLightLightGreyColor
          : kDarkLightGreyColor;
  static Color kGreyColor(BuildContext context) =>
      context.read<SwitchCubit>().isLightMode
          ? kLightGreyColorMode
          : kDarkGreyColorMode;
  static Color kMainButtonColor(BuildContext context) =>
      context.read<SwitchCubit>().isLightMode
          ? kLightMainButtonColor
          : kDarkMainButtonColor;
  static Color kAlarmColor(BuildContext context) =>
      context.read<SwitchCubit>().isLightMode
          ? kLightAlarmColor
          : kDarkAlarmColor;
  static Color kInputTextColor(BuildContext context) =>
      context.read<SwitchCubit>().isLightMode
          ? kLightInputTextColor
          : kDarkInputTextColor;
  static Color kAppBarColor(BuildContext context) =>
      context.read<SwitchCubit>().isLightMode
          ? kLightAppBarColor
          : kDarkAppBarColor;
  static Color kTextColor(BuildContext context) =>
      context.read<SwitchCubit>().isLightMode
          ? kLightTextColor
          : kDarkTextColor;
  static Color kPriceColor(BuildContext context) =>
      context.read<SwitchCubit>().isLightMode
          ? kLightPriceColor
          : kDarkPriceColor;

  static Color kyellowColor(BuildContext context) =>
      context.read<SwitchCubit>().isLightMode
          ? kYellowColor
          : kDarkYellowColor;
  static Color logoColor(BuildContext context) =>
      context.read<SwitchCubit>().isLightMode
          ? kLightLogoColor
          : kDarkLogoColor;
}
