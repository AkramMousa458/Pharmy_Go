import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/core/utils/constants.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/core/utils/icons.dart';
import 'package:pharmygo/patient/cubits/patient_cubit/patient_cubit.dart';
import 'package:pharmygo/patient/views/patient_profile_edit_page.dart';
import 'package:pharmygo/patient/widgets/profile_picture.dart';
import 'package:pharmygo/patient/widgets/shimmer_profile_patient.dart';
import 'package:pharmygo/public/widgets/custom_button.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';
import 'package:pharmygo/public/widgets/data_show.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class PatientProfilePage extends StatelessWidget {
  const PatientProfilePage({super.key});

  static const String routeName = "/PatientProfilePage";
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.kSecondBackgroundColor(context),
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: appBarSize,
        child: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(
              color: ThemeColors.kMainColor(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: BlocBuilder<PatientCubit, PatientState>(
        builder: (context, state) {
          if (state is FetchPatientSuccess) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    ProfilePicture(
                      picture: state.patient.imageUrl,
                    ),
                    Text(
                      state.patient.name,
                      style: TextStyle(
                        color: ThemeColors.kMainColor(context),
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.screenWidth(context) / 14.5,
                        // fontSize: 25,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, PatientProfileEditPage.routeName,
                              arguments: state.patient);
                        },
                        text: 'Edit Profile',
                        textSize: 18.sp,
                        width: 255.w,
                        height: 50.h,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DataShow(
                      icon: profileIcon,
                      data: state.patient.name,
                    ),
                    DataShow(
                      icon: emailIcon,
                      data: state.patient.email,
                    ),
                    DataShow(
                      icon: mobileIcon,
                      data: state.patient.phone,
                    ),
                    // const DataShow(
                    //   icon: diseaseIcon,
                    //   data: 'Nothing',
                    // ),
                  ],
                ),
              ),
            );
          } else if (state is FetchPatientFailure) {
            return Text(state.errMesage);
          } else if (state is FetchPatientLoading) {
            return const Center(
              child: ShimmerProfilePatient(),
            );
          } else {
            return const CustomLoadingIndicator();
          }
        },
      ),
    );
  }
}
