import 'package:flutter/material.dart';
import 'package:pharmygo/core/utils/constants.dart';
import 'package:pharmygo/core/utils/icons.dart';
import 'package:pharmygo/patient/widgets/custom_patient_drawer.dart';
import 'package:pharmygo/pharmacist/widgets/pharmacist_navigation_bar.dart';
import 'package:pharmygo/public/widgets/custom_app_bar.dart';
import 'package:pharmygo/public/widgets/custom_button.dart';
import 'package:pharmygo/public/widgets/custom_text_field.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});
  static const String routeName = "/testscreen";
  static final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      key: scaffoldKey,
      drawer: const Drawer(
        child: CustomPatientDrawer(),
      ),
      appBar: PreferredSize(
        preferredSize: appBarSize,
        child: CustomAppBar(
          endIcon: notificationsIcon,
          endIconAction: () {},
          scaffoldKey: scaffoldKey,
        ),
      ),
      backgroundColor: ThemeColors.kBackgroundColor(context),
      bottomNavigationBar: const PharmacistNavigationBar(),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(text: "ahmed", onPressed: () {}),
          const SizedBox(width: 5),
          const CustomTextField(
            isPassword: true,
            endIcon: eyeIcon,
          ),
        ],
      ),
    );
  }
}
