import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/core/utils/assets.dart';
import 'package:pharmygo/core/utils/icons.dart';
import 'package:pharmygo/public/cubits/auth_cubit/auth_cubit.dart';
import 'package:pharmygo/public/cubits/pickup_image_cubit/pickup_image_cubit.dart';
import 'package:pharmygo/public/cubits/select_type_cubit/select_type_cubit.dart';
import 'package:pharmygo/public/views/login_view.dart';
import 'package:pharmygo/public/widgets/custom_button.dart';
import 'package:pharmygo/public/widgets/custom_checkbox.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';
import 'package:pharmygo/public/widgets/login_text_field.dart';
import 'package:pharmygo/public/widgets/pickup_photo_bottom_sheet.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

bool isLoading = false;

class SignupView extends StatelessWidget {
  const SignupView({super.key});
  static String routeName = "/signupView";
  @override
  Widget build(BuildContext context) {
    String name = "";
    String password = "";
    String email = "";
    String confPassword = "";
    String phone = "";
    final logInFormKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: ThemeColors.kAppBarColor(context),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Column(
                  children: [
                    Image.asset(
                      AssetData.logoIcon,
                      fit: BoxFit.contain,
                      height: 100.h,
                      width: 100.w,
                    ),
                    Text(
                      "Signup",
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                        color: ThemeColors.logoColor(context),
                      ),
                    ),
                  ],
                ),
              ),
              BlocProvider(
                create: (context) => SelectTypeCubit(),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(ScreenUtil().setWidth(30)),
                      topRight: Radius.circular(ScreenUtil().setWidth(30)),
                    ),
                    color: ThemeColors.kSecondBackgroundColor(context),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Form(
                      key: logInFormKey,
                      child: Column(
                        children: [
                          LoginTextField(
                            hintText: 'Full Name',
                            onChanged: (value) {
                              name = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a Name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10.h),
                          LoginTextField(
                            hintText: 'Email',
                            onChanged: (value) {
                              email = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an Email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10.h),
                          LoginTextField(
                            hintText: 'Phone Number',
                            onChanged: (value) {
                              phone = value;
                            },
                            isNumber: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a Phone Number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10.h),
                          // LoginTextField(
                          //   hintText: 'Password',
                          //   onChanged: (value) {
                          //     password = value;
                          //   },
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'Please enter a Password';
                          //     }
                          //     return null;
                          //   },
                          //   iconSuffix:
                          //       Icon(eyeIcon, size: ScreenUtil().setWidth(23)),
                          //   isPassword: true,
                          // ),
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              return LoginTextField(
                                hintText: 'Password',
                                onChanged: (value) {
                                  password = value;
                                },
                                iconSuffix: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<AuthCubit>(context)
                                        .hidePassword();
                                  },
                                  icon: BlocProvider.of<AuthCubit>(context)
                                          .isHidden
                                      ? const FaIcon(eyeIcon)
                                      : const FaIcon(eyeIconSlash),
                                ),
                                isPassword: BlocProvider.of<AuthCubit>(context)
                                    .isHidden,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a Password';
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                          SizedBox(height: 10.h),
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              return LoginTextField(
                                hintText: 'Confirm Password',
                                onChanged: (value) {
                                  confPassword = value;
                                },
                                iconSuffix: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<AuthCubit>(context)
                                        .hidePassword();
                                  },
                                  icon: BlocProvider.of<AuthCubit>(context)
                                          .isHidden
                                      ? const FaIcon(eyeIcon)
                                      : const FaIcon(eyeIconSlash),
                                ),
                                isPassword: BlocProvider.of<AuthCubit>(context)
                                    .isHidden,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please repeat the Password';
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                          SizedBox(height: 10.h),
                          BlocBuilder<SelectTypeCubit, SelectTypeState>(
                            builder: (context, state) {
                              if (state is SelectTypePharmacist) {
                                return GestureDetector(
                                  onTap: () {
                                    pickupPhotoBottomSheet(
                                        context: context,
                                        title: "Upload ID Card");
                                  },
                                  child: BlocBuilder<PickupImageCubit,
                                      PickupImageState>(
                                    builder: (context, state) {
                                      return LoginTextField(
                                        hintText: state is PickupImageSuccess
                                            ? 'ID Card Uploaded Successfully'
                                            : 'Attach Syndicate ID Card',
                                        onChanged: (value) {},
                                        iconSuffix: FaIcon(fileIcon, size: 22.sp),
                                        isEnabled: false,
                                        validator: (value) {
                                          if (context
                                                  .read<PickupImageCubit>()
                                                  .selectedImage ==
                                              null) {
                                            return 'Please upload an ID Card';
                                          }
                                          return null;
                                        },
                                      );
                                    },
                                  ),
                                );
                              } else {
                                isPatient = true;
                                isPharmacy = false;
                                return const SizedBox();
                              }
                            },
                          ),
                          BlocConsumer<SelectTypeCubit, SelectTypeState>(
                            listener: (context, state) {
                              if (state is SelectTypePatient) {
                                isPatient = true;
                                isPharmacy = false;
                              } else if (state is SelectTypePharmacist) {
                                isPharmacy = true;
                                isPatient = false;
                              }
                            },
                            builder: (context, state) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 14.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        context
                                            .read<SelectTypeCubit>()
                                            .changeType(type: "Patient");
                                      },
                                      child: CustomCheckBox(
                                        text: "Patient",
                                        onChange: (value) {
                                          context
                                              .read<SelectTypeCubit>()
                                              .changeType(type: "Patient");
                                        },
                                        check: isPatient,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context
                                            .read<SelectTypeCubit>()
                                            .changeType(type: "Pharmacist");
                                      },
                                      child: CustomCheckBox(
                                        text: "Pharmacist",
                                        onChange: (value) {
                                          context
                                              .read<SelectTypeCubit>()
                                              .changeType(type: "Pharmacist");
                                        },
                                        check: isPharmacy,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 30.h),
                          BlocConsumer<AuthCubit, AuthState>(
                            listener: (BuildContext context, state) {
                              if (state is AuthFailure) {
                                showSnackBar(context, state.errMessage);
                              } else if (state is AuthSuccess) {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  LoginView.routeName,
                                  (route) => false,
                                );
                              }
                            },
                            builder: (BuildContext context, state) {
                              bool isLoading = state is AuthLoading;
                              return isLoading
                                  ? const Center(
                                      child: CustomLoadingIndicator())
                                  : CustomButton(
                                      isBold: true,
                                      backgroundColor:
                                          ThemeColors.kSecondButtonColor(
                                              context),
                                      textColor:
                                          ThemeColors.kMainColor(context),
                                      text: 'Submit',
                                      onPressed: () {
                                        if (logInFormKey.currentState!
                                            .validate()) {
                                          if (isPatient) {
                                            BlocProvider.of<AuthCubit>(context)
                                                .signupPatient(
                                              name: name,
                                              email: email,
                                              password: password,
                                              confPassword: confPassword,
                                              phone: phone,
                                            );
                                          } else if (isPharmacy) {
                                            BlocProvider.of<AuthCubit>(context)
                                                .signupPharmacist(
                                              name: name,
                                              email: email,
                                              password: password,
                                              confPassword: confPassword,
                                              phone: phone,
                                              idCard: context
                                                  .read<PickupImageCubit>()
                                                  .selectedImage!,
                                            );
                                          } else {
                                            showSnackBar(context,
                                                "Please Select User Type!");
                                          }
                                        }
                                      },
                                    );
                            },
                          ),
                          SizedBox(height: 50.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}








// Container for the "Pharmacist" tab
                            // Padding(
                            //   padding:
                            //       EdgeInsets.all(ScreenUtil().setWidth(20)),
                            //   child: ListView(
                            //     physics: const BouncingScrollPhysics(),
                            //     children: [
                            //       LoginTextField(
                            //         hintText: 'Full Name',
                            //         onChanged: (value) {},
                            //       ),
                            //       SizedBox(height: ScreenUtil().setHeight(20)),
                            //       LoginTextField(
                            //         hintText: 'Email',
                            //         onChanged: (value) {},
                            //       ),
                            //       SizedBox(height: ScreenUtil().setHeight(20)),
                            //       LoginTextField(
                            //         hintText: 'Phone Number',
                            //         onChanged: (value) {},
                            //         isNumber: true,
                            //       ),
                            //       SizedBox(height: ScreenUtil().setHeight(20)),
                                  // LoginTextField(
                                  //   hintText: 'Attach Syndicate ID Card',
                                  //   onChanged: (value) {},
                                  //   iconSuffix: Icon(fileIcon,
                                  //       size: ScreenUtil().setWidth(23)),
                                  // ),
                            //       SizedBox(height: ScreenUtil().setHeight(20)),
                            //       LoginTextField(
                            //         hintText: 'Password',
                            //         onChanged: (value) {},
                            //         iconSuffix: Icon(eyeIcon,
                            //             size: ScreenUtil().setWidth(23)),
                            //         isPassword: true,
                            //       ),
                            //       SizedBox(height: ScreenUtil().setHeight(20)),
                            //       LoginTextField(
                            //         hintText: 'Confirm Password',
                            //         onChanged: (value) {},
                            //         iconSuffix: Icon(eyeIcon,
                            //             size: ScreenUtil().setWidth(23)),
                            //         isPassword: true,
                            //       ),
                            //       SizedBox(height: ScreenUtil().setHeight(30)),
                            //       CustomButton(
                            //         isBold: true,
                            //         backgroundColor:  ThemeColors.kSecondButtonColor(context),
                            //         textColor:  ThemeColors.kMainColor(context),
                            //         text: 'Submit',
                            //         onPressed: () {
                            //           Navigator.pushNamed(
                            //               context, LoginView.routeName);
                            //         },
                            //       ),
                            //     ],
                            //   ),
                            // ),