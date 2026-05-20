import 'package:flutter/material.dart';
import 'package:pharmygo/core/utils/constants.dart';
import 'package:pharmygo/pharmacist/widgets/custom_pharmacist_drawer.dart';
import 'package:pharmygo/pharmacist/widgets/pharmacist_navigation_bar.dart';
import 'package:pharmygo/public/widgets/custom_app_bar.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class NoMedicinesPage extends StatelessWidget {
  const NoMedicinesPage({super.key});

  static const routeName = '/NoMedicinesPage';
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: ThemeColors.kBackgroundColor(context),
        key: scaffoldKey,
        drawer: const Drawer(
          child: CustomPharmacistDrawer(),
        ),
        appBar: PreferredSize(
          preferredSize: appBarSize,
          child: CustomAppBar(
            scaffoldKey: scaffoldKey,
          ),
        ),
        bottomNavigationBar: const PharmacistNavigationBar(),
        body: Center(
          child: Text(
            'No Medicines',
            style: TextStyle(
              color: ThemeColors.kThirdTextColor(context),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
