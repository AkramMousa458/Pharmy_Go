import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pharmygo/patient/models/patient_model.dart';
import 'package:pharmygo/pharmacist/models/nearst_pharmacy_model.dart';
import 'package:pharmygo/public/models/order_model.dart';

import '../../../../core/errors/failures.dart';

abstract class PatientsRepo {
  Future<Either<Failure, PatientModel>> getPatient();
  Future<Either<Failure, PatientModel>> updatePatient({
    String? name,
    String? email,
    String? password,
    String? confPassword,
    String? phone,
    File? profileImage,
  });

  Future<Either<Failure, String>> updatePatientLocation({
    required String longitude,
    required String latitude,
  });

  Future<Either<Failure, List<NearestPharmacyModel>>>
      getNearstPharmaciesWithDrug({
    required int drugId,
  });

  Future<Either<Failure, List<NearestPharmacyModel>>> getNearstPharmacies();

  Future<Either<Failure, void>> addOrderToCart(
      {required int pharmacyId, required int drugId, required int quantity});

  Future<Either<Failure, String>> deleteOrderFromCart({required int orderId});

  Future<Either<Failure, List<OrderModel>>> getCart();

  Future<Either<Failure, void>> addOrder(
      {required int pharmacyId, required int drugId, required int quantity});

  Future<Either<Failure, List<OrderModel>>> getOrders();
}
