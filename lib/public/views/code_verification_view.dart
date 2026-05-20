import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/core/utils/assets.dart';
import 'package:pharmygo/public/views/forget_password_view.dart';
import 'package:pharmygo/public/views/login_view.dart';

import '../widgets/custom_button.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class CodeVerificationView extends StatefulWidget {
  const CodeVerificationView({super.key});
  static String routeName = "CodeVerificationView";

  @override
  State<CodeVerificationView> createState() => _CodeVerificationViewState();
}

class _CodeVerificationViewState extends State<CodeVerificationView> {
  int _countDown = 30;
  bool _showResendText = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countDown == 0) {
        setState(() {
          _showResendText = true;
          _timer.cancel();
        });
      } else {
        setState(() {
          _countDown--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Image.asset(
                Assets.codeVerification,
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
                  padding: const EdgeInsets.only(top: 50),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Text(
                      "Message sended to your email!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ThemeColors.kSecondColor(context),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment
                          .center, // Aligns the entire row to the center
                      children: [
                        Text(
                          "Check your email and reset the password",
                          textAlign: TextAlign
                              .center, // Aligns this text to the center
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: ThemeColors.kGreyColor(context),
                          ),
                        ),

                        // Text(
                        //   "+20 109 952 7790",
                        //   textAlign: TextAlign
                        //       .center, // Aligns this text to the center
                        //   style: TextStyle(
                        //     fontSize: 14,
                        //     fontWeight: FontWeight.normal,
                        //     color: ThemeColors.kSecondColor(context),
                        //   ),
                        // ),
                      ],
                    ),
                    //  const SizedBox(
                    //   height: 10,
                    // ),
                    //  const CustomPinCode(),
                    //  const SizedBox(height: 15),
                    SizedBox(
                      height: 100.h,
                    ),
                    CustomButton(
                      // width: 360,
                      isBold: true,
                      backgroundColor: ThemeColors.kSecondColor(context),
                      textColor: ThemeColors.kSecondButtonColor(context),
                      text: 'Done',
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          LoginView.routeName,
                          (route) => false,
                        );
                      },
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    _showResendText
                        ? Row(
                            children: [
                              Text(
                                "Don't receive code? ",
                                style: TextStyle(
                                    color: ThemeColors.kGreyColor(context)),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, ForgetPasswordView.routeName);
                                },
                                child: Text(
                                  "Re-send",
                                  style: TextStyle(
                                      color: ThemeColors.kSecondColor(context)),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Text(
                                "Don't receive code? ",
                                style: TextStyle(
                                    color: ThemeColors.kGreyColor(context)),
                              ),
                              Text(
                                "$_countDown s",
                                style: TextStyle(
                                    color: ThemeColors.kSecondColor(context)),
                              ),
                            ],
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
