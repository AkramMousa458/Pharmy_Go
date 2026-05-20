import 'package:flutter/material.dart';
import 'package:pharmygo/core/utils/assets.dart';
import 'package:pharmygo/public/views/done_reset_password_view.dart';
import 'package:pharmygo/public/widgets/forget_password_text_field.dart';
import '../../core/utils/dimensions.dart';
import '../widgets/custom_button.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class SetNewPasswordView extends StatelessWidget {
  const SetNewPasswordView({super.key});
  static String routeName = "SetNewPasswordView";

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
                Assets.newPassword,
                fit: BoxFit.contain,
                height: 220,
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
                    Text(
                      "New Password",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: ThemeColors.kSecondColor(context),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(30), // Make it circular
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: ForgetPasswordTextField(
                        onChanged: (value) {},
                        isPassword: true,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Confirm Password",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: ThemeColors.kSecondColor(context),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(30), // Make it circular
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: ForgetPasswordTextField(
                        onChanged: (value) {},
                        isPassword: true,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      // width: 360,
                      isBold: true,
                      backgroundColor: ThemeColors.kSecondColor(context),
                      textColor: ThemeColors.kSecondButtonColor(context),
                      text: 'Submit',
                      onPressed: () {
                        Navigator.pushNamed(
                            context, DoneResetPasswordView.routeName);
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: ThemeColors.kSecondColor(context),
                      ),
                      textAlign: TextAlign.center,
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
