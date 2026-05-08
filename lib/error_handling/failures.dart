import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  const Failure({required this.errMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errMessage});

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errMessage: 'Connection timeout with server');
      case DioExceptionType.sendTimeout:
        return ServerFailure(errMessage: 'Send timeout with Server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errMessage: 'Receive timeout with Server');
      case DioExceptionType.badCertificate:
        return ServerFailure(errMessage: 'Bad certificate connect');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure(errMessage: 'Requset to server was canceld');
      case DioExceptionType.connectionError:
        return ServerFailure(
            errMessage: 'Connection error, Restart connection and try agian');
      case DioExceptionType.unknown:
        return ServerFailure(errMessage: 'Unexpected error, Please try again');

      default:
        return ServerFailure(errMessage: dioException.toString());
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(errMessage: response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure(errMessage: 'Error 404 not found, Please try again');
    } else if (statusCode == 500) {
      return ServerFailure(errMessage: 'Server Failure, Please try later!');
    } else {
      return ServerFailure(
          errMessage: 'Opps there was an error, Please try again');
    }
  }
}
