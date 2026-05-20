import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/utils/colors.dart';
import 'package:pharmygo/patient/views/donation_view.dart';
import 'package:pharmygo/patient/views/my_cart_view.dart';
import 'package:pharmygo/patient/views/patient_home_page.dart';
import 'package:pharmygo/patient/views/patient_profile_page.dart';

class NavigationBarTransitionPatientForProfile extends StatefulWidget {
  const NavigationBarTransitionPatientForProfile(
      {super.key, this.isHomePage = false});
  static const routeName = '/NavigationBarTransitionPatientForProfile';
  final bool isHomePage;
  @override
  State<NavigationBarTransitionPatientForProfile> createState() =>
      _NavigationBarTransitionPatientForProfileState();
}

class _NavigationBarTransitionPatientForProfileState
    extends State<NavigationBarTransitionPatientForProfile> {
  final screens = const [
    PatientHomePage(),
    PatientProfilePage(),
    MyCartView(),
    DonationView(),
  ];

  final items = [
    const FaIcon(
      FontAwesomeIcons.houseMedical,
      size: 22,
      color: kSecondColor,
    ),
    const FaIcon(
      FontAwesomeIcons.userMd,
      size: 22,
      color: kSecondColor,
    ),
    const FaIcon(
      FontAwesomeIcons.pills,
      size: 22,
      color: kSecondColor,
    ),
    const FaIcon(
      FontAwesomeIcons.handHoldingHeart,
      size: 22,
      color: kSecondColor,
    ),
  ];

  int index = 1;
  final PageController _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        children: screens,
        onPageChanged: (pageIndex) {
          setState(() {
            index = pageIndex;
          });
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        items: items,
        index: index,
        onTap: (pageIndex) {
          _pageController.animateToPage(
            pageIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}
