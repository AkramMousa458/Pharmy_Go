import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/core/utils/api_services.dart';
import 'package:pharmygo/core/utils/constants.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/core/utils/icons.dart';
import 'package:pharmygo/patient/cubits/update_patient_location/update_patient_location_cubit.dart';
import 'package:pharmygo/patient/repos/patients_repo/patients_repo_impl.dart';
import 'package:pharmygo/patient/views/patient_drug_view.dart';
import 'package:pharmygo/patient/views/people_screen.dart';
import 'package:pharmygo/public/cubits/fetch_drugs_cubit/fetch_drugs_cubit.dart';
import 'package:pharmygo/patient/views/patient_drugs_list_view.dart';
import 'package:pharmygo/patient/widgets/custom_patient_drawer.dart';
import 'package:pharmygo/patient/widgets/shimmer_home_page_patient.dart';
import 'package:pharmygo/patient/widgets/custom_slider.dart';
import 'package:pharmygo/patient/widgets/drugs_list.dart';
import 'package:pharmygo/patient/widgets/option_list.dart';
import 'package:pharmygo/public/views/ocr_page.dart';
import 'package:pharmygo/public/widgets/custom_app_bar.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';
import 'package:pharmygo/public/widgets/custom_search.dart';
import 'package:pharmygo/public/widgets/custom_text_field.dart';
import 'package:permission_handler/permission_handler.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});
  static const String routeName = "/homepagepatient";
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  @override
  void initState() {
    requestLocationPermission();
    super.initState();
  }

  Future<void> requestLocationPermission() async {
    log('open');
    var status = await Permission.location.status;
    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      if (await Permission.location.request().isGranted) {
        // Either the permission was already granted before or the user just granted it.
        log('Location permission granted');
      }
    } else if (status.isPermanentlyDenied) {
      log('isPermanentlyDenied');
      // The user opted to never again see the permission request dialog for this app.
      // The only way to change the permission now is to let the user manually enable it in the system settings.
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    return BlocProvider(
      create: (context) =>
          UpdatePatientLocationCubit(PatientsRepoImpl(ApiService(Dio())))
            ..updatePatientLocation(longitude: '', latitude: ''),
      child: Scaffold(
        backgroundColor: ThemeColors.kBackgroundColor(context),
        key: PatientHomePage.scaffoldKey,
        drawer: const Drawer(
          child: CustomPatientDrawer(),
        ),
        appBar: PreferredSize(
          preferredSize: appBarSize,
          child: CustomAppBar(
            scaffoldKey: PatientHomePage.scaffoldKey,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                CustomTextField(
                  width: Dimensions.screenWidth(context) - 50,
                  startIcon: searchIcon,
                  endIcon: cameraIcon,
                  onTapEndIcon: () {
                    Navigator.pushNamed(context, OcrPage.routeName);
                  },
                  onTap: () {
                    showSearch(context: context, delegate: CustomSearch());
                  },
                ),
                SizedBox(height: 4.h),
                CustomSlider(),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // BlocConsumer<GetNearstPharmaciesCubit,
                        //     GetNearstPharmaciesState>(
                        //   listener: (context, state) {
                        //     if (state is GetNearstPharmaciesSuccsess) {
                        //       Navigator.pushNamed(
                        //           context, FindNearestPharmacisOnMap.routeName);
                        //     }
                        //   },
                        //   builder: (context, state) {
                        //     return OptionListItem(
                        //       onTap: () async {
                        //         BlocProvider.of<GetNearstPharmaciesCubit>(
                        //                 context)
                        //             .getNearstPharmacies();
                        //       },
                        //       icon: pharmacyIcon,
                        //       title: "Pharmacy",
                        //     );
                        //   },
                        // ),
                        OptionListItem(
                          onTap: () {
                            // Navigator.pushNamed(context, AlarmPage.routeName);
                          },
                          icon: alarmIcon,
                          title: "Alarm",
                        ),
                        OptionListItem(
                          onTap: () {
                            Navigator.pushNamed(context, PeopleScreen.routeName,
                                arguments: 'patient');
                          },
                          icon: chatIcon,
                          title: "Chat",
                        ),
                        OptionListItem(
                          onTap: () {
                            Navigator.pushNamed(
                                context, PatientDrugsListView.routeName);
                          },
                          icon: drugsIcon,
                          title: "Drugs",
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        // width: 30,
                        width: Dimensions.screenWidth(context) * 0.07,
                      ),
                      Text(
                        "Available Drugs",
                        style: TextStyle(
                          color: ThemeColors.kMainColor(context),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.screenWidth(context) * 0.4,
                      ),
                      GestureDetector(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, PatientDrugsListView.routeName);
                          },
                          child: Text(
                            "view more",
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: ThemeColors.kSecondColor(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                BlocBuilder<FetchDrugsCubit, FetchDrugsState>(
                  builder: (context, state) {
                    if (state is FetchDrugsSuccess) {
                      return state.drugs.isEmpty
                          ? SizedBox(
                              height: 240,
                              child: Center(child: Text("No drugs found")))
                          : SizedBox(
                              height: 240,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: ListView.builder(
                                  itemCount: state.drugs.length > 10
                                      ? 10
                                      : state.drugs.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return DrugsList(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          PatientDrugView.routeName,
                                          arguments: state.drugs[index],
                                        );
                                      },
                                      drugModel: state.drugs[index],
                                    );
                                  },
                                ),
                              ),
                            );
                    } else if (state is FetchDrugsFailure) {
                      return Text(state.errMesage);
                    } else if (state is FetchDrugsLoading) {
                      return SizedBox(
                        height: 240,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return const ShimmerHomePagePatient();
                            },
                          ),
                        ),
                      );
                    } else {
                      return const CustomLoadingIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
