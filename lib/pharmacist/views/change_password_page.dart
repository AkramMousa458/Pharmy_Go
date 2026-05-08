import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/core/utils/icons.dart';
import 'package:pharmygo/public/widgets/custom_button.dart';
import 'package:pharmygo/public/widgets/custom_text_field.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  static const String routeName = "/ChangePasswordPage";
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double? fontSize = 17, iconSize = 23;
    return Scaffold(
      backgroundColor: ThemeColors.kSecondBackgroundColor(context),
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50),
        child: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Change Password',
            style: TextStyle(
              color: ThemeColors.kMainColor(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                color: ThemeColors.kMainColor(context)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Old Password',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: ThemeColors.kMainColor(context),
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 15),
                      child: CustomTextField(
                          startIcon: passwordIcon,
                          isPassword: true,
                          endIcon: eyeIcon,
                          endIconSize: iconSize,
                          width: Dimensions.screenWidth(context) * 0.80),
                    ),
                    Text(
                      'New Password',
                      style: TextStyle(
                          color: ThemeColors.kMainColor(context),
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 15),
                      child: CustomTextField(
                          startIcon: passwordIcon,
                          endIcon: eyeIcon,
                          isPassword: true,
                          endIconSize: iconSize,
                          width: Dimensions.screenWidth(context) * 0.80),
                    ),
                    Text(
                      'Confirm-Password',
                      style: TextStyle(
                          color: ThemeColors.kMainColor(context),
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 15),
                      child: CustomTextField(
                          startIcon: passwordIcon,
                          endIcon: eyeIcon,
                          endIconSize: iconSize,
                          isPassword: true,
                          width: Dimensions.screenWidth(context) * 0.80),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                  ],
                ),
                CustomButton(
                  text: 'Save',
                  onPressed: () {
                    showSnackBar(context, 'Password Changed');

                    Navigator.pop(context);
                  },
                  width: Dimensions.screenWidth(context) * 0.366,
                  borderRadius: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
