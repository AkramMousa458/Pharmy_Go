import 'package:flutter/material.dart';
import 'package:pharmygo/core/utils/colors.dart';

class CustomSwitch extends StatelessWidget {
   const CustomSwitch({
    super.key,
    this.onChanged,
    this.isActive = false ,
    this.activeColor = kSecondColor,
  });
    final bool isActive;
  final Color activeColor;
  final Function(bool)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: Switch(
        
        activeColor: kSecondColor,
        onChanged:onChanged, 
        value: isActive,
      ),
    );
  }
}
