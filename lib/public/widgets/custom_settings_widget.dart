import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/public/cubits/switch_cubit/switch_cubit.dart';
import 'package:pharmygo/public/widgets/custom_switch.dart';

class CustomSettingsWidget extends StatelessWidget {
   const CustomSettingsWidget({
    super.key,
  });
  final double fontSize = 14;
  final double iconSize = 20;
  @override
  Widget build(BuildContext context) {
    bool isEn = true, isDarkMode = false;
    return ExpansionTile(
      shape:  const Border(),
      leading:  Icon(
        Icons.settings,
        color: ThemeColors.kSecondColor(context),
      ),
      title: Text(
        "Settings",
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: ThemeColors.kSecondColor(context),
        ),
      ),
      children: [
        Row(
          children: [
             const SizedBox(width: 50),
             Icon(
              Icons.dark_mode,
              color: ThemeColors.kSecondColor(context),
            ),
             const SizedBox(width: 5),
            Text(
              "Dark Mode",
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: ThemeColors.kSecondColor(context),
              ),
            ),
             const SizedBox(width: 30),
            BlocConsumer<SwitchCubit, SwitchState>(
              listener: (context, state) {
                if (state is SwitchToLightMode) {
                  isDarkMode =
                      BlocProvider.of<SwitchCubit>(context).isLightMode;
                } else if (state is SwitchToDarkMode) {
                  isDarkMode =
                      BlocProvider.of<SwitchCubit>(context).isLightMode;
                }
              },
              builder: (context, state) {
                return CustomSwitch(
                  activeColor: ThemeColors.kSecondColor(context),
                  isActive: isDarkMode,
                  onChanged: (state) {
                    BlocProvider.of<SwitchCubit>(context)
                        .switchToLightMode(state);
                  },
                );
              },
            )
          ],
        ),
         const SizedBox(height: 10),
        BlocConsumer<SwitchCubit, SwitchState>(
          listener: (context, state) {
            if (state is SwitchToEn) {
              isEn = BlocProvider.of<SwitchCubit>(context).isEn;
            } else if (state is SwitchToAr) {
              isEn = BlocProvider.of<SwitchCubit>(context).isEn;
            }
          },
          builder: (context, state) {
            return Row(
              children: [
                 const SizedBox(width: 50),
                 Icon(
                  Icons.language,
                  color: ThemeColors.kSecondColor(context),
                ),
                 const SizedBox(width: 7),
                Text(
                  "English",
                  style: TextStyle(
                    fontSize: fontSize,
                    color: ThemeColors.kSecondColor(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 const SizedBox(width: 55),
                CustomSwitch(
                  activeColor: ThemeColors.kSecondColor(context),
                  isActive: isEn,
                  onChanged: (state) {
                    BlocProvider.of<SwitchCubit>(context).switchToEn(state);
                  },
                )
              ],
            );
          },
        ),
      ],
    );
  }
}
