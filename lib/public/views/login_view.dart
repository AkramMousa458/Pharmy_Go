import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/utils/assets.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/core/utils/icons.dart';
import 'package:pharmygo/patient/views/navigation_bar_transition_patient_for_home_page.dart';
import 'package:pharmygo/pharmacist/views/navigation_bar_transition_pharmacy_for_home_page.dart';
import 'package:pharmygo/public/cubits/auth_cubit/auth_cubit.dart';
import 'package:pharmygo/public/cubits/select_type_cubit/select_type_cubit.dart';
import 'package:pharmygo/public/views/forget_password_view.dart';
import 'package:pharmygo/public/views/signup_view.dart';
import 'package:pharmygo/public/widgets/custom_button.dart';
import 'package:pharmygo/public/widgets/custom_checkbox.dart';
import 'package:pharmygo/public/widgets/login_text_field.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

bool isPharmacy = false;
bool isPatient = false;
// final logInFormKey = GlobalKey<FormState>();
String email = "";
String password = "";

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static String routeName = "loginView";

  static final logInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // String email = "";
    // String password = "";
    return Scaffold(
      backgroundColor: ThemeColors.kAppBarColor(context),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  Image.asset(
                    Assets.logoIcon,
                    fit: BoxFit.contain,
                    height: 120.0,
                    width: 120.0,
                  ),
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.logoColor(context),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: Dimensions.screenWidth(context),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: ThemeColors.kSecondBackgroundColor(context),
                ),
                child: Padding(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                  child: Form(
                    key: logInFormKey,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        LoginTextField(
                          hintText: 'Phone / Email',
                          onChanged: (value) {
                            email = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a Phone / Email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.h),
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
                                icon:
                                    BlocProvider.of<AuthCubit>(context).isHidden
                                        ? const FaIcon(eyeIcon)
                                        : const FaIcon(eyeIconSlash),
                              ),
                              isPassword:
                                  BlocProvider.of<AuthCubit>(context).isHidden,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a Password';
                                }
                                return null;
                              },
                            );
                          },
                        ),
                        BlocProvider(
                          create: (context) => SelectTypeCubit(),
                          child: BlocConsumer<SelectTypeCubit, SelectTypeState>(
                            listener: (context, state) {
                              if (state is SelectTypePatient) {
                                isPatient = true;
                                isPharmacy = false;
                              } else if (state is SelectTypePharmacist) {
                                isPharmacy = true;
                                isPatient = false;
                              } else {
                                isPatient = true;
                                isPharmacy = false;
                              }
                            },
                            builder: (context, state) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14.0),
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
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Center(
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ForgetPasswordView.routeName);
                              },
                              child: Text(
                                "Forget Password?",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: ThemeColors.kSecondColor(context),
                                ),
                              ),
                            ),
                          ),
                        ),
                        BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is AuthFailure) {
                              showSnackBar(context, state.errMessage);
                            } else if (state is AuthSuccess) {
                              if (isPatient) {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  NavigationBarTransitionPatientForHomePage
                                      .routeName,
                                  (route) => false,
                                );
                              } else if (isPharmacy) {
                                Navigator.pushReplacementNamed(
                                    context,
                                    NavigationBarTransitionPharmacyForHomePage
                                        .routeName);
                              }
                            }
                          },
                          builder: (context, state) {
                            bool isLoading = state is AuthLoading;

                            return CustomButton(
                              isBold: true,
                              backgroundColor:
                                  ThemeColors.kSecondButtonColor(context),
                              textColor: ThemeColors.kMainColor(context),
                              isLoading: isLoading,
                              text: 'Login',
                              onPressed: () {
                                if (isPatient) {
                                  if (logInFormKey.currentState!.validate()) {
                                    BlocProvider.of<AuthCubit>(context)
                                        .loginUser(
                                      email: email,
                                      password: password,
                                      userType: "patient",
                                    );
                                  }
                                } else if (isPharmacy) {
                                  if (logInFormKey.currentState!.validate()) {
                                    BlocProvider.of<AuthCubit>(context)
                                        .loginUser(
                                      email: email,
                                      password: password,
                                      userType: "pharmacist",
                                    );
                                  }
                                } else {
                                  showSnackBar(
                                      context, "Please Select User Type!");
                                }
                              },
                            );
                          },
                      ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 20.0),
                        //   child: Row(
                        //     children: [
                        //       Expanded(
                        //         child: Container(
                        //           height:
                        //               2, // Adjust the height of the horizontal line
                        //           color: ThemeColors.kGreyColor(context),
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.symmetric(
                        //             horizontal: 16.0),
                        //         child: Text(
                        //           "or sign in with",
                        //           style: TextStyle(
                        //             fontSize: 16.sp,
                        //             fontWeight: FontWeight.bold,
                        //             color: ThemeColors.kGreyColor(context),
                        //           ),
                        //         ),
                        //       ),
                        //       Expanded(
                        //         child: Container(
                        //           height:
                        //               2, // Adjust the height of the horizontal line
                        //           color: ThemeColors.kGreyColor(context),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // GoogleButton(
                        //   onPressed: () {},
                        //   text: "Continue with Google",
                        // ),
                        SizedBox(
                          height: 25.h,
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.pushNamed(context, SignupView.routeName);
                          },
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: ThemeColors.kSecondColor(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
