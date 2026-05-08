import 'package:flutter/material.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/public/widgets/custom_button.dart';
import 'package:pharmygo/public/widgets/custom_text_field.dart';

class PatientsRegisterView extends StatelessWidget {
  const PatientsRegisterView({super.key});

  static const routeName = '/PatientsRegisterView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomTextField(
                label: "Full Name",
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomTextField(
                label: "Email",
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomTextField(
                label: "Phone Number",
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomTextField(
                label: "Password",
                isPassword: true,
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomTextField(
                label: "Confirm-Password",
                isPassword: true,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                  onPressed: () {
                    showSnackBar(context, "Not Finsh");
                  },
                  text: "Sign Up")
            ],
          ),
        ),
      ),
    );
  }
}
