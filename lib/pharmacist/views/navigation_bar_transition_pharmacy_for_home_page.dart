import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/utils/colors.dart';
import 'package:pharmygo/pharmacist/views/doctor_profile_page.dart';
import 'package:pharmygo/pharmacist/views/pharmacist_pages/pharmacist_home_page.dart';
import 'package:pharmygo/pharmacist/views/pharmacist_pages/pharmacist_my_medicines_page.dart';

class NavigationBarTransitionPharmacyForHomePage extends StatefulWidget {
  const NavigationBarTransitionPharmacyForHomePage({super.key});
  static const routeName = '/NavigationBarTransitionPharmacyForHomePage';

  @override
  State<NavigationBarTransitionPharmacyForHomePage> createState() =>
      _NavigationBarTransitionPharmacyForHomePageState();
}

class _NavigationBarTransitionPharmacyForHomePageState
    extends State<NavigationBarTransitionPharmacyForHomePage> {
  final screens = const [
    PharmacistHomePage(),
    DoctorProfilePage(),
    MyMedicinesListView(),
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
  ];

  int index = 0;
  final PageController _pageController = PageController();

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
