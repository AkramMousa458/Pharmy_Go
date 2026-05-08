// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmygo/core/utils/api_services.dart';
import 'package:pharmygo/patient/cubits/add_order_cubit/add_drug_cart_cubit.dart';
import 'package:pharmygo/patient/cubits/add_order_to_cart_cubit/add_order_to_cart_cubit.dart';
import 'package:pharmygo/patient/cubits/donation/donation_cubit.dart';
import 'package:pharmygo/patient/cubits/get_cart/get_cart_cubit.dart';
import 'package:pharmygo/patient/cubits/get_nearst_pharmacies/get_nearst_pharmacies_cubit.dart';
import 'package:pharmygo/patient/cubits/get_nearst_pharmacies_with_drug_cubit/get_nearst_pharmacies_with_drug_cubit.dart';
import 'package:pharmygo/patient/cubits/get_orders/get_orders_cubit.dart';
import 'package:pharmygo/patient/cubits/patient_cubit/patient_cubit.dart';
import 'package:pharmygo/patient/cubits/update_patient_profile/update_patient_profile_cubit.dart';
import 'package:pharmygo/patient/repos/donation_repo/donation_repo_impl.dart';
import 'package:pharmygo/patient/repos/patients_repo/patients_repo_impl.dart';
import 'package:pharmygo/pharmacist/cubits/add_medcine/add_medcine_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/add_pharmacy_cubit/add_pharmacy_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/delete_medcine_from_pharmacy_cubit/delete_medcine_from_pharmacy_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/delete_medicine_cubit/delete_medicine_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/delete_order_cubit/delete_order_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/delivery_cubit/delivery_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/get_my_medcines_cubit/get_my_medcines_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/get_my_pharmacies_cubit/get_my_pharmacies_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/get_pharmacy_orders/get_pharmacy_orders_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/get_shortage_drug_cubit/get_shortage_drug_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/pharmacist_cubit/pharmacist_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/update_pharmacist/update_pharmacist_cubit.dart';
import 'package:pharmygo/pharmacist/repos/pharmacist_repo/pharmacist_repo_impl.dart';
import 'package:pharmygo/public/cubits/chat_cubit/chat_cubit.dart';
import 'package:pharmygo/public/cubits/fetch_drugs_cubit/fetch_drugs_cubit.dart';
import 'package:pharmygo/patient/cubits/paymob_manager_cubit/paymob_manager_cubit.dart';
import 'package:pharmygo/patient/repos/paymob_manager_repo/paymob_manager_repo_impl.dart';
import 'package:pharmygo/public/cubits/auth_cubit/auth_cubit.dart';
import 'package:pharmygo/public/cubits/pickup_image_cubit/pickup_image_cubit.dart';
import 'package:pharmygo/public/cubits/quantity_counter_cubit/quantity_counter_cubit.dart';
import 'package:pharmygo/public/cubits/switch_cubit/switch_cubit.dart';
import 'package:pharmygo/public/cubits/trip_cubit/trip_cubit.dart';
import 'package:pharmygo/public/repos/auth_repo/auth_repo_impl.dart';
import 'package:pharmygo/public/repos/drugs_repo/drugs_repo_impl.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  BlocProvider(
    create: (context) =>
        PaymobManagerCubit(PaymobManagerRepoImpl(ApiService(Dio()))),
  ),
  BlocProvider(
    create: (context) =>
        FetchDrugsCubit(DrugsRepoImpl(ApiService(Dio())))..fetchDrugs(),
  ),
  BlocProvider(
    create: (context) =>
        PatientCubit(PatientsRepoImpl(ApiService(Dio())))..getPatient(),
  ),
  BlocProvider(
    create: (context) =>
        PharmacistCubit(PharmacistRepoImpl(ApiService(Dio())))..getPharmaicst(),
  ),
  BlocProvider(
    create: (context) => AuthCubit(
      AuthRepoImpl(ApiService(Dio())),
    ),
  ),
  BlocProvider(
    create: (context) => PickupImageCubit(),
  ),
  BlocProvider(
    create: (context) => UpdatePatientProfileCubit(
      PatientsRepoImpl(ApiService(Dio())),
    ),
  ),
  BlocProvider(
    create: (context) => UpdatePharmacistCubit(
      PharmacistRepoImpl(ApiService(Dio())),
    ),
  ),
  BlocProvider(
    create: (context) => GetMyPharmaciesCubit(
      PharmacistRepoImpl(ApiService(Dio())),
    )..getMyPharmacies(),
  ),
  BlocProvider(
    create: (context) => GetNearstPharmciesWithDrugCubit(
      PatientsRepoImpl(ApiService(Dio())),
    ),
  ),
  BlocProvider(
    create: (context) => DonationCubit(
      DonationRepoImpl(ApiService(Dio())),
    ),
  ),
  BlocProvider(
    create: (context) => GetNearstPharmaciesCubit(
      PatientsRepoImpl(ApiService(Dio())),
    ),
  ),
  BlocProvider(
    create: (context) => AddOrderCubit(
      PatientsRepoImpl(ApiService(Dio())),
    ),
  ),
  BlocProvider(
    create: (context) => QuantityCounterCubit(),
  ),
  BlocProvider(
    create: (context) => TripCubit(),
  ),
  BlocProvider(
    create: (context) => SwitchCubit(),
  ),
  BlocProvider(
    create: (context) => GetOrdersCubit(
      PatientsRepoImpl(ApiService(Dio())),
    ),
  ),
  BlocProvider(
    create: (context) => AddOrderToCartCubit(
      PatientsRepoImpl(ApiService(Dio())),
    ),
  ),
  BlocProvider(
    create: (context) => GetCartCubit(
      PatientsRepoImpl(ApiService(Dio())),
    ),
  ),
  BlocProvider(
    create: (context) => GetMyMedcinesCubit(
      PharmacistRepoImpl(ApiService(Dio())),
    ),
  ),
  BlocProvider(
    create: (context) => AddMedcineCubit(
      PharmacistRepoImpl(ApiService(Dio())),
    ),
  ),
  BlocProvider(
    create: (context) => DeleteMedicineCubit(
      PharmacistRepoImpl(ApiService(Dio())),
    ),
  ),
  BlocProvider(
    create: (context) => DeliveryCubit(),
  ),
  BlocProvider(
    create: (context) => AddPharmacyCubit(
      PharmacistRepoImpl(ApiService(Dio())),
    ),
  ),
  BlocProvider(
    create: (context) => GetShortageDrugCubit(
      PharmacistRepoImpl(ApiService(Dio())),
    ),
  ),
  BlocProvider(
    create: (context) => ChatCubit(),
  ),
  BlocProvider(
    create: (context) => GetPharmacyOrdersCubit(
      PharmacistRepoImpl(ApiService(Dio())),
    ),
  ),
  BlocProvider(
    create: (context) => DeleteMedcineFromPharmacyCubit(
      PharmacistRepoImpl(ApiService(Dio())),
    ),
  ),
  BlocProvider(
    create: (context) => DeleteOrderCubit(
      PharmacistRepoImpl(ApiService(Dio())),
    ),
  ),
];
