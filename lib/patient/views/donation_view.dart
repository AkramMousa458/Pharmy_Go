import 'package:flutter/material.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/patient/views/donation_view_body.dart';

class DonationView extends StatelessWidget {
  const DonationView({super.key});
  static const routeName = '/DonationView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Donate Drug',
            style: TextStyle(
              color: ThemeColors.kMainColor(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: const Center(child: DonationViewBody()));
  }
}
