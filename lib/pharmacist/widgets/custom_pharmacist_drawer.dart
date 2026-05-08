import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmygo/core/utils/assets.dart';
import 'package:pharmygo/pharmacist/cubits/pharmacist_cubit/pharmacist_cubit.dart';
import 'package:pharmygo/pharmacist/views/navigation_bar_transition_pharmcy_for_profile.dart';
import 'package:pharmygo/public/cubits/auth_cubit/auth_cubit.dart';
import 'package:pharmygo/public/views/login_view.dart';
import 'package:pharmygo/public/widgets/custom_drawer_tile.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';
import 'package:pharmygo/public/widgets/custom_settings_widget.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class CustomPharmacistDrawer extends StatelessWidget {
  const CustomPharmacistDrawer({super.key});
  final double fontSize = 16;
  final double iconSize = 16;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: ThemeColors.kSecondBackgroundColor(context),
            child: BlocBuilder<PharmacistCubit, PharmacistState>(
              builder: (context, state) {
                if (state is FetchPharmacistSuccess) {
                  return Column(
                    children: [
                      Container(
                        width: 800,
                        height: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AssetData.pharmacyPhoto),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.pharmacist.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.kSecondColor(context),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CustomLoadingIndicator(),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              alignment: Alignment.centerLeft,
              color: ThemeColors.kBackgroundColor(context),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  CustomDrawerTile(
                    title: "Profile",
                    icon: Icons.person,
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        NavigationBarTransitionPharmacyForProfile.routeName,
                        (route) => false,
                      );
                    },
                  ),
                  // CustomDrawerTile(
                  //   title: "News",
                  //   icon: Icons.newspaper,
                  //   onTap: () {
                  //     Navigator.pushNamed(
                  //       context,
                  //       NewsView.routeName,
                  //     );
                  //   },
                  // ),
                  Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      const SizedBox(
                        width: 300,
                        height: 300,
                        child: Column(
                          children: [
                            CustomSettingsWidget(),
                            Divider(
                              endIndent: 20,
                              indent: 30,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 300, left: 10, right: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.black,
                            elevation: 0.5,
                            shape: const StadiumBorder(),
                            backgroundColor: ThemeColors.kMainColor(context),
                            minimumSize: const Size(320, 48),
                          ),
                          onPressed: () {
                            BlocProvider.of<AuthCubit>(context).logout();
                            Navigator.pushNamedAndRemoveUntil(
                                context, LoginView.routeName, (route) => false);
                          },
                          child: Text(
                            "Log out",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18,
                                color: ThemeColors.kTextColor(context)),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
