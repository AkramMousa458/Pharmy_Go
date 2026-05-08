import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/patient/cubits/patient_cubit/patient_cubit.dart';
import 'package:pharmygo/patient/views/navigation_bar_transition_patient_for_profile.dart';
import 'package:pharmygo/patient/widgets/custom_shimmer_child_profile_picture.dart';
import 'package:pharmygo/patient/widgets/profile_picture.dart';
import 'package:pharmygo/public/cubits/auth_cubit/auth_cubit.dart';
import 'package:pharmygo/public/views/login_view.dart';
import 'package:pharmygo/public/views/news_view.dart';
import 'package:pharmygo/public/widgets/custom_drawer_tile.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';
import 'package:pharmygo/public/widgets/custom_settings_widget.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/public/widgets/custom_shimmer_child.dart';

class CustomPatientDrawer extends StatelessWidget {
  const CustomPatientDrawer({super.key});

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
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: BlocBuilder<PatientCubit, PatientState>(
                builder: (context, state) {
                  if (state is FetchPatientSuccess) {
                    return Column(
                      children: [
                        ProfilePicture(
                          picture: state.patient.imageUrl,
                          radius: 50,
                        ),
                        Text(
                          state.patient.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ThemeColors.kSecondColor(context),
                          ),
                        ),
                      ],
                    );
                  } else if (state is FetchPatientFailure) {
                    return Text(state.errMesage);
                  } else if (state is FetchPatientLoading) {
                    return Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(15),
                          child: CustomShimmerChildProfilePicture(
                            radius: 50,
                          ),
                        ),
                        CustomShimmerChild(
                          width: 90.w,
                          height: 15.h,
                        ),
                      ],
                    );
                  }
                  return const Center(child: CustomLoadingIndicator());
                },
              ),
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
                        NavigationBarTransitionPatientForProfile.routeName,
                        (route) => false,
                      );
                    },
                  ),
                  CustomDrawerTile(
                    title: "Orders history",
                    icon: Icons.history,
                    onTap: () {},
                  ),
                  CustomDrawerTile(
                    title: "News",
                    icon: Icons.newspaper,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        NewsView.routeName,
                      );
                    },
                  ),
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
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 200, left: 10, right: 10),
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
