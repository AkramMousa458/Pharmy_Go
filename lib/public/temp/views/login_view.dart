import 'package:flutter/material.dart';
import 'package:pharmygo/patient/views/navigation_bar_transition_patient_for_home_page.dart';
import 'package:pharmygo/pharmacist/views/navigation_bar_transition_pharmacy_for_home_page.dart';
import 'package:pharmygo/public/temp/views/patients_register_view.dart';
import 'package:pharmygo/public/temp/views/pharmacist_register_view.dart';
import 'package:pharmygo/public/widgets/custom_button.dart';
import 'package:pharmygo/public/widgets/custom_text_field.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  static String routeName = "/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomTextField(
            hintText: "username",
          ),
          const SizedBox(
            height: 20,
          ),
          const CustomTextField(
            hintText: "password",
            isPassword: true,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Pharmacist",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) {},
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Patient",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
          CustomButton(
            text: "Login patient",
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, NavigationBarTransitionPatientForHomePage.routeName);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            text: "Register patient",
            onPressed: () {
              Navigator.pushNamed(context, PatientsRegisterView.routeName);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            text: "Login pharmacy",
            onPressed: () {
              Navigator.pushReplacementNamed(context,
                  NavigationBarTransitionPharmacyForHomePage.routeName);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            text: "Register pharmacy",
            onPressed: () {
              Navigator.pushNamed(context, PharmacistRegisterView.routeName);
            },
          ),
        ],
      ),
    );
  }
}
