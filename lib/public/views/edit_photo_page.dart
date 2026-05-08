// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/utils/constants.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/core/utils/icons.dart';
import 'package:pharmygo/patient/cubits/patient_cubit/patient_cubit.dart';
import 'package:pharmygo/patient/cubits/update_patient_profile/update_patient_profile_cubit.dart';
import 'package:pharmygo/patient/models/patient_model.dart';
import 'package:pharmygo/patient/widgets/profile_picture.dart';
import 'package:pharmygo/public/cubits/pickup_image_cubit/pickup_image_cubit.dart';
import 'package:pharmygo/public/widgets/custom_button.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';
import 'package:pharmygo/public/widgets/custom_text_field.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class EditPhotoPage extends StatelessWidget {
  const EditPhotoPage({super.key});

  static const String routeName = "/editPhotoPage";
  static final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    PatientModel patient =
        ModalRoute.of(context)!.settings.arguments as PatientModel;
    bool isLoading = false;
    return Scaffold(
      backgroundColor: ThemeColors.kSecondBackgroundColor(context),
      key: scaffoldKey,
      appBar: PreferredSize(
          preferredSize: appBarSize,
          child: AppBar(
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: ThemeColors.kMainColor(context)),
            ),
          )),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              BlocConsumer<PickupImageCubit, PickupImageState>(
                listener: (context, state) {
                  if (state is PickupImageFailure) {
                    showSnackBar(context, state.errMessage);
                  } else if (state is PickupImageSuccess) {
                    showSnackBar(context, 'Successfully');
                  }
                },
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: state is PickupImageSuccess
                        ? ProfilePicture(
                            file: state.image,
                            picture: '',
                          )
                        : ProfilePicture(
                            picture: patient.imageUrl,
                          ),
                  );
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: SizedBox(
                  height: 150.h,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Profile Photo",
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            const FaIcon(deleteIcon),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<PickupImageCubit>()
                                        .pickupImage(
                                            context: context, fromCamera: true);
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    size: 70,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text("Camera"),
                              ],
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<PickupImageCubit>()
                                        .pickupImage(
                                            context: context,
                                            fromCamera: false);
                                  },
                                  icon: const Icon(
                                    size: 70,
                                    Icons.photo,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text("Gallery"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomTextField(
                    startIcon: FontAwesomeIcons.person,
                    hintText: patient.name,
                    isEnabled: false,
                    onChange: (data) {
                      patient.name = data;
                    },
                    width: Dimensions.screenWidth(context) * 0.80,
                    hintColor: ThemeColors.kSecondColor(context)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: BlocConsumer<UpdatePatientProfileCubit,
                    UpdatePatientProfileState>(
                  listener: (context, state) {
                    if (state is UpdatePatientSuccess) {
                      isLoading = false;
                      showSnackBar(context, 'Saved');
                      BlocProvider.of<PatientCubit>(context).getPatient();
                    } else if (state is UpdatePatientFailure) {
                      BlocProvider.of<PatientCubit>(context).getPatient();
                      showSnackBar(context, state.errMessage);
                      isLoading = false;
                    } else {
                      isLoading = true;
                    }
                  },
                  builder: (context, state) {
                    File? selectedImage =
                        BlocProvider.of<PickupImageCubit>(context)
                            .selectedImage;
                    return isLoading
                        ? const CustomLoadingIndicator()
                        : CustomButton(
                            text: 'Save',
                            width: Dimensions.screenWidth(context) * 0.80,
                            onPressed: () {
                              // BlocProvider.of<UpdatePatientProfileCubit>(
                              //         context)
                              //     .updatePatient(
                              //         name: patient.name,
                              //         phone: patient.phone,
                              //         profileImage: selectedImage);
                            },
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
