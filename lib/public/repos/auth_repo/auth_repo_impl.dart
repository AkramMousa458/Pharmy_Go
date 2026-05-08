// ignore_for_file: unused_local_variable, avoid_print

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
// import 'package:http_parser/http_parser.dart';
import '../../../core/errors/failures.dart';
import '../../../core/utils/api_services.dart';
import '../../models/auth_model.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService apiService;

  AuthRepoImpl(this.apiService);
  @override
  Future<Either<Failure, AuthModel>> loginUser({
    required String email,
    required String password,
    required String userType,
  }) async {
    try {
      var data = await apiService.post(
          endPoint:
              'login?userLogin=$email&password=$password&user_type=$userType',
          data: {});
      print(data['message']);
      AuthModel authModel = AuthModel.fromJson(data['message']);
      return right(authModel);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, AuthModel>> signupPatient({
    required String name,
    required String email,
    required String password,
    required String confPassword,
    required String phone,
  }) async {
    FormData formData = FormData.fromMap({
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'password_confirmation': confPassword,
      'user_type': 'patient',
    });
    try {
      var data = await apiService.post(
        endPoint: 'register',
        data: formData,
      );
      // AuthModel authModel = AuthModel.fromJson(data);
      // print(data["message"]);
      AuthModel authModel =
          AuthModel(name: '', email: '', phone: '', userType: '', id: 0);
      return right(authModel);
    } catch (e) {
      if (e is DioException) {
        // print('DioException: ${e.response?.data}');
        return left(
          ServerFailure(
            e.response?.data['message'],
          ),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, AuthModel>> signupPharmacist({
    required String name,
    required String email,
    required String password,
    required String confPassword,
    required String phone,
    required File idCard,
  }) async {
    FormData formData = FormData.fromMap({
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'password_confirmation': confPassword,
      'user_type': 'pharmacist',
      'syndicate_id': await MultipartFile.fromFile(
        idCard.path,
        contentType: MediaType('image', 'jpeg'),
      ),
    });

    try {
      var data = await apiService.post(
        endPoint: 'register',
        data: formData,
      );
      AuthModel authModel = AuthModel.fromJson(data['message']);
      return right(authModel);
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.response?.data}');
        return left(
          ServerFailure(
            e.response?.data,
          ),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }
  
  @override
  Future<Either<Failure, String>> resetPassword({ required String email}) async {
    try {
      print(email);
      var data = await apiService.post(
          endPoint:
              'password/reset?email=$email',
          data: {});
      print(data['message']);
      return right(data['message']);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }
}
