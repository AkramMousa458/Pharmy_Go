import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/core/utils/assets.dart';
import 'package:pharmygo/public/cubits/auth_cubit/auth_cubit.dart';
import 'package:pharmygo/public/widgets/forget_password_text_field.dart';

import '../../core/utils/dimensions.dart';
import '../widgets/custom_button.dart';
import 'code_verification_view.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

String email = '';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});
  static String routeName = "ForgetPasswordView";
  static final forgetPasskey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return Scaffold(
      key: forgetPasskey,
      backgroundColor: ThemeColors.kSecondBackgroundColor(context),
      // appBar: PreferredSize(
      //   preferredSize: appBarSize,
      //   child: AlarmAppBar(
      //     backgroundcolor: ThemeColors.kSecondBackgroundColor(context),
      //     fristIcon: backArrow,
      //     fristiconcolor: ThemeColors.kSecondColor(context),
      //     fristIconAction: () {
      //       Navigator.pushNamed(context, LoginView.routeName);
      //     },
      //   ),
      // ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Image.asset(
              AssetData.forgetPassword,
              fit: BoxFit.contain,
              height: 420,
              width: Dimensions.screenWidth(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                children: [
                  Text(
                    "Forget Password?",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.kSecondColor(context),
                    ),
                  ),
                  Text(
                    "Enter email to receive the code to reset your password.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: ThemeColors.kSecondColor(context),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    // width: 360,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(25), // Make it circular
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: -0.5,
                          blurRadius: 5,
                          offset: const Offset(
                              3, 0), // Adjust shadow position as needed
                        ),
                      ],
                    ),
                    child: ForgetPasswordTextField(
                      hintText: "Enter the email",
                      // isNumber: true,
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthFailure) {
                        isLoading = false;
                        showSnackBar(context, state.errMessage);
                      } else if (state is AuthSuccess) {
                        isLoading = false;
                        Navigator.pushNamed(
                            context, CodeVerificationView.routeName);
                      } else {
                        isLoading = true;
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        // width: 360,
                        isBold: true,
                        backgroundColor: ThemeColors.kSecondColor(context),
                        textColor: ThemeColors.kSecondButtonColor(context),
                        text: 'Continue',
                        isLoading: isLoading,
                        onPressed: () {
                          BlocProvider.of<AuthCubit>(context)
                              .reserPassword(email: email);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
