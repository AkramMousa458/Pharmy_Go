import 'package:flutter/material.dart';
import 'package:pharmygo/core/utils/assets.dart';
import '../../../core/utils/dimensions.dart';
import '../../../public/widgets/custom_button.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class WelcomeDoctorView extends StatelessWidget {
  const WelcomeDoctorView({super.key});
  static String routeName = "WelcomeDoctorView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.kSecondBackgroundColor(context),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 110, bottom: 45),
              child: Image.asset(
                AssetData.welcomeDoctor,
                fit: BoxFit.contain,
                height: Dimensions.screenHeight(context) - 300,
                width: Dimensions.screenWidth(context),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    CustomButton(
                      // width: 360,
                      isBold: true,
                      backgroundColor: ThemeColors.kMainColor(context),
                      textColor: ThemeColors.kSecondButtonColor(context),
                      text: 'Submit',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
