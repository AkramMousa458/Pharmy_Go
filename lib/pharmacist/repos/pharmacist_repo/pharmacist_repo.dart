import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pharmygo/core/errors/failures.dart';
import 'package:pharmygo/pharmacist/models/pharmacist_model.dart';
import 'package:pharmygo/pharmacist/models/pharmacy_model.dart';
import 'package:pharmygo/pharmacist/models/pharmacy_orders_model.dart';
import 'package:pharmygo/public/models/drug_model.dart';
import 'package:pharmygo/public/models/shortage_drug_model.dart';

abstract class PharmacistRepo {
  Future<Either<Failure, PharmacistModel>> getPharmacist();
  Future<Either<Failure, PharmacistModel>> updatePharmacist({
    String? name,
    String? email,
    String? password,
    String? confPassword,
    String? phone,
    File? profileImage,
  });

  Future<Either<Failure, List<PharmacyModel>>> getMyPharmacies();

  Future<Either<Failure, List<DrugModel>>> getMyMedcines(
      {required int pharmacyId});

  Future<Either<Failure, String>> addMedicine({
    required int pharmacyId,
    required int drugId,
    required int quantity,
  });
  Future<Either<Failure, String>> addPharmacy({
    required int pharmacyId,
    required int delivery,
    required String pharmacyName,
    required double longitude,
    required double latitude,
  });

  Future<Either<Failure, String>> deleteMedicine(
      {required int pharmacyId, required int drugId});

  Future<Either<Failure, List<ShortageDrugModel>>> getShortageDrugs(
      {required int pharmacyId});

  Future<Either<Failure, List<PharmacyOrderModel>>> getPharmacyOrders({required int pharmacyId});

  
  Future<Either<Failure, String>> deleteOrder(
      {required int patientId, required int orderId});
}
