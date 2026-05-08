import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/utils/colors.dart';
import 'package:pharmygo/pharmacist/views/doctor_profile_page.dart';
import 'package:pharmygo/pharmacist/views/pharmacist_pages/pharmacist_home_page.dart';
import 'package:pharmygo/pharmacist/views/pharmacist_pages/pharmacist_my_medicines_page.dart';

class NavigationBarTransitionPharmacyForProfile extends StatefulWidget {
  const NavigationBarTransitionPharmacyForProfile(
      {super.key, this.isHomePage = false});
  static const routeName = '/NavigationBarTransitionPharmacyForProfile';
  final bool isHomePage;
  @override
  State<NavigationBarTransitionPharmacyForProfile> createState() =>
      _NavigationBarTransitionPharmacyForProfileState();
}

class _NavigationBarTransitionPharmacyForProfileState
    extends State<NavigationBarTransitionPharmacyForProfile> {
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

  int index = 1;
  final PageController _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
