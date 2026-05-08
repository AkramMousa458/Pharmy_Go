
import 'package:dartz/dartz.dart';
import 'package:pharmygo/patient/models/donation_model.dart';

import '../../../../core/errors/failures.dart';

abstract class DonationRepo {
  Future<Either<Failure, DonationModel>> addDonation({
required String nameOfMedcine,
required String address,
required String quantityOfMedcine,

  });
}
