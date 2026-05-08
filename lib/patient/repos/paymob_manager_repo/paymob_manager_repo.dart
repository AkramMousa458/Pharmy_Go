import 'package:dartz/dartz.dart';
import 'package:pharmygo/error_handling/failures.dart';

abstract class PaymobManagerRepo {
  Future<Either<Failure, String>> getAuthanticationToken();

  Future<Either<Failure, int>> getOrderId({
    required String authToken,
    required bool deliveryNeeded,
    required String amountCents,
    required String currency,
  });

  Future<Either<Failure, String>> getAcceptancePaymentKey({
    required String authToken,
    required String amountCents,
    required String orderId,
    required String currency,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
  });
}
