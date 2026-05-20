// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/core/utils/assets.dart';
import 'package:pharmygo/public/views/login_view.dart';
import 'package:pharmygo/public/views/signup_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class StartView2 extends StatelessWidget {
  const StartView2({super.key});
  static const String routeName = 'StartScreen2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.kSecondBackgroundColor(context),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 70, right: 70),
                  child: Image.asset(Assets.smartphoneDr),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                textAlign: TextAlign.center,
                "WELCOME, ",
                style: TextStyle(
                    color: ThemeColors.kMainColor(context),
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                textAlign: TextAlign.center,
                "Hope your health well. ",
                style: TextStyle(
                    color: ThemeColors.kMainColor(context),
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 60.h),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.black,
                    elevation: 0.5,
                    shape: const StadiumBorder(),
                    backgroundColor: ThemeColors.kSecondButtonColor(context),
                    minimumSize: Size(325.w, 40.h),
                  ),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('initial', true);
                    Navigator.pushNamed(context, LoginView.routeName);
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.kMainColor(context),
                    ),
                  )),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('initial', true);
                  Navigator.pushNamed(context, SignupView.routeName);
                },
                child: Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: ThemeColors.kSecondColor(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
