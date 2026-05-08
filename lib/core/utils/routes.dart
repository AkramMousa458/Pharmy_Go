import 'package:pharmygo/patient/views/chat_screen.dart';
import 'package:pharmygo/patient/views/checkout_shipping_view.dart';
import 'package:pharmygo/patient/views/checkout_order_view.dart';
import 'package:pharmygo/patient/views/checkout_payment_view.dart';
import 'package:pharmygo/patient/views/donation_view.dart';
import 'package:pharmygo/patient/views/navigation_bar_transition_patient_for_profile.dart';
import 'package:pharmygo/patient/views/patient_home_page.dart';
import 'package:pharmygo/patient/views/my_cart_view.dart';
import 'package:pharmygo/patient/views/navigation_bar_transition_patient_for_home_page.dart';
import 'package:pharmygo/patient/views/order_finished_view.dart';
import 'package:pharmygo/patient/views/patient_drug_view.dart';
import 'package:pharmygo/patient/views/patient_drugs_list_view.dart';
import 'package:pharmygo/patient/views/people_screen.dart';

import 'package:pharmygo/pharmacist/views/navigation_bar_transition_pharmacy_for_home_page.dart';
import 'package:pharmygo/pharmacist/views/navigation_bar_transition_pharmcy_for_profile.dart';

import 'package:pharmygo/pharmacist/views/pharmacist_pages/no_medicines_page.dart';
import 'package:pharmygo/pharmacist/views/pharmacist_pages/pharmacist_home_page.dart';
import 'package:pharmygo/pharmacist/views/pharmacist_pages/pharmacist_my_medicines_page.dart';
import 'package:pharmygo/patient/views/patient_profile_edit_page.dart';
import 'package:pharmygo/patient/views/patient_profile_page.dart';
import 'package:pharmygo/pharmacist/views/add_pharmacy_page.dart';
import 'package:pharmygo/pharmacist/views/change_password_page.dart';
import 'package:pharmygo/pharmacist/views/doctor_edit_profile_page.dart';
import 'package:pharmygo/pharmacist/views/doctor_profile_page.dart';
import 'package:pharmygo/pharmacist/views/edit_pharmacy_page.dart';
import 'package:pharmygo/public/temp/views/patients_register_view.dart';
import 'package:pharmygo/public/temp/views/pharmacist_register_view.dart';
import 'package:pharmygo/public/views/edit_photo_page.dart';
import 'package:pharmygo/public/views/login_view.dart';
import 'package:pharmygo/public/views/map/find_pharmacy_on_map_with_drug.dart';
import 'package:pharmygo/public/views/map/find_nearest_pharmacis_on_map.dart';
import 'package:pharmygo/public/views/news_view.dart';
import 'package:pharmygo/public/views/ocr_page.dart';
import 'package:pharmygo/public/views/signup_view.dart';
import 'package:pharmygo/public/views/start_view.dart';
import 'package:pharmygo/public/views/start_view_2.dart';
import 'package:pharmygo/public/views/test_view.dart';
import '../../pharmacist/views/pharmacist_pages/done_pharmacist_registeration.dart';
import '../../pharmacist/views/pharmacist_pages/welcome_doctor_view.dart';
import '../../public/views/done_reset_password_view.dart';
import '../../public/views/forget_password_view.dart';
import '../../public/views/code_verification_view.dart';
import '../../public/views/set_new_password_view.dart';

var routes = {
  //StartView
  StartView.routeName: (context) => const StartView(),
  StartView2.routeName: (context) => const StartView2(),
  TestView.routeName: (context) => const TestView(),

  //login and signup
  LoginView.routeName: (context) => const LoginView(),
  SignupView.routeName: (context) => const SignupView(),
  ForgetPasswordView.routeName: (context) => const ForgetPasswordView(),
  CodeVerificationView.routeName: (context) => const CodeVerificationView(),
  SetNewPasswordView.routeName: (context) => const SetNewPasswordView(),
  DoneResetPasswordView.routeName: (context) => const DoneResetPasswordView(),

  //doctor
  WelcomeDoctorView.routeName: (context) => const WelcomeDoctorView(),
  DonePharmacistRegisterationView.routeName: (context) =>
      const DonePharmacistRegisterationView(),
  PharmacistRegisterView.routeName: (context) => const PharmacistRegisterView(),
  PharmacistHomePage.routeName: (context) => const PharmacistHomePage(),
  DoctorProfilePage.routeName: (context) => const DoctorProfilePage(),
  DoctorProfileEditPage.routeName: (context) => const DoctorProfileEditPage(),
  AddPharmacyPage.routeName: (context) => const AddPharmacyPage(),
  EditPharmacyPage.routeName: (context) => const EditPharmacyPage(),

  //patient
  PatientHomePage.routeName: (context) => const PatientHomePage(),
  FindPharmacyOnMapWithDrug.routeName: (context) =>
      const FindPharmacyOnMapWithDrug(),
  PatientDrugsListView.routeName: (context) => const PatientDrugsListView(),
  PatientDrugView.routeName: (context) => const PatientDrugView(),
  MyCartView.routeName: (context) => const MyCartView(),
  CheckoutPaymentView.routeName: (context) => const CheckoutPaymentView(),
  CheckoutShippingView.routeName: (context) => const CheckoutShippingView(),
  CheckoutOrderView.routeName: (context) => const CheckoutOrderView(),
  OrderFinishedView.routeName: (context) => const OrderFinishedView(),
  MyMedicinesListView.routeName: (context) => const MyMedicinesListView(),
  NoMedicinesPage.routeName: (context) => const NoMedicinesPage(),

  PatientProfilePage.routeName: (context) => const PatientProfilePage(),
  PatientProfileEditPage.routeName: (context) => const PatientProfileEditPage(),
  ChangePasswordPage.routeName: (context) => const ChangePasswordPage(),

  NavigationBarTransitionPatientForHomePage.routeName: (context) =>
      const NavigationBarTransitionPatientForHomePage(),
  NavigationBarTransitionPatientForProfile.routeName: (context) =>
      const NavigationBarTransitionPatientForProfile(),
  NavigationBarTransitionPharmacyForHomePage.routeName: (context) =>
      const NavigationBarTransitionPharmacyForHomePage(),
  NavigationBarTransitionPharmacyForProfile.routeName: (context) =>
      const NavigationBarTransitionPharmacyForProfile(),
  // AlarmEditScreen.routeName: (context) => const AlarmEditScreen(),
  // AlarmHomeScreen.routeName: (context) => const AlarmHomeScreen(),

  PatientsRegisterView.routeName: (context) => const PatientsRegisterView(),
  EditPhotoPage.routeName: (context) => const EditPhotoPage(),
  FindNearestPharmacisOnMap.routeName: (context) =>
      const FindNearestPharmacisOnMap(),
  DonationView.routeName: (context) => const DonationView(),
  PeopleScreen.routeName: (context) =>  const PeopleScreen(),
  ChatScreen.routeName: (context) => ChatScreen(),
  NewsView.routeName: (context) => const NewsView(),
  OcrPage.routeName: (context) => const OcrPage(),
};
