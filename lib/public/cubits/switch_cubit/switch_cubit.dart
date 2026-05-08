import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pharmygo/core/theme/theme.dart';

part 'switch_state.dart';

class SwitchCubit extends Cubit<SwitchState> {
  SwitchCubit() : super(SwitchInitial());
  bool isEn = true, isLightMode = true;
  ThemeData themeData = lightMode;
  
  void switchToLightMode(bool isDarkMode) {
    if (isDarkMode && themeData == darkMode) {
      isLightMode = true;
      themeData = lightMode;

      emit(SwitchToLightMode());
    } else {
      isLightMode = false;
      themeData = darkMode;
      emit(SwitchToDarkMode());
    }
  }

  void switchToEn(bool isAr) {
    if (isAr) {
      isEn = true;
      emit(SwitchToEn());
    } else {
      isEn = false;
      emit(SwitchToAr());
    }
  }
}
