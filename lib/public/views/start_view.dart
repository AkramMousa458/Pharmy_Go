import 'package:flutter/material.dart';
import 'package:pharmygo/core/utils/assets.dart';
import 'package:pharmygo/patient/views/navigation_bar_transition_patient_for_home_page.dart';
import 'package:pharmygo/pharmacist/views/navigation_bar_transition_pharmacy_for_home_page.dart';
import 'package:pharmygo/public/views/login_view.dart';
import 'package:pharmygo/public/views/start_view_2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});
  static const String routeName = 'startView';

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  @override
  void initState() {
    navigateToHome(context);
    super.initState();
  }

  navigateToHome(context) {
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (prefs.getBool('initial') == false ||
            prefs.getBool('initial') == null) {
          Navigator.pushReplacementNamed(context, StartView2.routeName);
        } else if (prefs.getInt('auth-id') == null) {
          Navigator.pushReplacementNamed(context, LoginView.routeName);
        } else {
          if (prefs.getString('type') == 'pharmacist') {
            Navigator.pushReplacementNamed(
                context, NavigationBarTransitionPharmacyForHomePage.routeName);
          } else if (prefs.getString('type') == 'patient') {
            Navigator.pushReplacementNamed(
                context, NavigationBarTransitionPatientForHomePage.routeName);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ThemeColors.kSecondBackgroundColor(context),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const SizedBox(height: 50),
            Image.asset(AssetData.logo),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     shadowColor: Colors.black,
            //     elevation: 0.5,
            //     shape: const StadiumBorder(),
            //     backgroundColor:  ThemeColors.kSecondButtonColor(context),
            //     minimumSize: const Size(342, 48),
            //   ),
            //   onPressed: () {
            //     Navigator.pushNamed(context, StartView2.routeName);
            //   },
            //   child: const Text(
            //     "Get Started",
            //     style: TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.bold,
            //       color:  ThemeColors.kMainColor(context),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 2),
          ],
        ),
      ),
    );
  }
}
