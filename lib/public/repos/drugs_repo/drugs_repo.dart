import 'package:dartz/dartz.dart';
import 'package:pharmygo/public/models/drug_model.dart';

import '../../../../core/errors/failures.dart';

abstract class DrugsRepo {
  Future<Either<Failure, List<DrugModel>>> fetchDrugs();
  Future<Either<Failure, String>> addOrderToCard({
    required String patientId,
    required String pharmacyId,
    required int drugId,
    required int quantity,
  });
}
