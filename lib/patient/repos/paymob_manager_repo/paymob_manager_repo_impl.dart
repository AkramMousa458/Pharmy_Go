import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pharmygo/core/utils/api_services.dart';
import 'package:pharmygo/error_handling/failures.dart';
import 'package:pharmygo/patient/helper/payment_keys.dart';
import 'package:pharmygo/patient/repos/paymob_manager_repo/paymob_manager_repo.dart';

class PaymobManagerRepoImpl implements PaymobManagerRepo {
  final ApiService apiService;
  PaymobManagerRepoImpl(this.apiService);


  @override
  Future<Either<Failure, String>> getAuthanticationToken() async {
    try {
      var data = await apiService.post(
        endPoint: "https://accept.paymob.com/api/auth/tokens",
        data: {
          "api_key": PaymentKeys.apiKey,
        },
      );
      return right(data["token"]);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioException(e),
        );
      }
      return left(
        ServerFailure(
          errMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> getOrderId({
    required String authToken,
    required bool deliveryNeeded,
    required String amountCents,
    required String currency,
  }) async {
    try {

      final Response response = await Dio()
          .post("https://accept.paymob.com/api/ecommerce/orders", data: {
        "auth_token": authToken,
        "delivery_needed": "false",
        "currency": currency,
        "amount_cents": amountCents,
        "items": [],
      });

      return right(response.data["id"]);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioException(e),
        );
      }
      return left(
        ServerFailure(
          errMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> getAcceptancePaymentKey({
    required String authToken,
    required String amountCents,
    required String orderId,
    required String currency,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
  }) async {
    try {
      final Response response = await Dio()
          .post("https://accept.paymob.com/api/acceptance/payment_keys", data: {
        "auth_token": authToken,
        "amount_cents": amountCents,
        "expiration": 3600,
        "order_id": orderId,
        "currency": currency,
        "integration_id": PaymentKeys.cardPaymentMethodIntegrationID,
        "billing_data": {
          //Must take a vaild value
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "phone_number": phoneNumber,

          //Can be NA
          "apartment": "803",
          "floor": "42",
          "street": "Ethan Land",
          "building": "8028",
          "shipping_method": "PKG",
          "postal_code": "01898",
          "city": "Jaskolskiburgh",
          "country": "CR",
          "state": "Utah"
        }
      });

      return right(response.data["token"]);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioException(e),
        );
      }
      return left(
        ServerFailure(
          errMessage: e.toString(),
        ),
      );
    }
  }
}
