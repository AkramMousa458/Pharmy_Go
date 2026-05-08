import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../models/auth_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, AuthModel>> loginUser({
    required String email,
    required String password,
    required String userType,
  });
  Future<Either<Failure, AuthModel>> signupPatient({
    required String name,
    required String email,
    required String password,
    required String confPassword,
    required String phone,
  });
  Future<Either<Failure, AuthModel>> signupPharmacist({
    required String name,
    required String email,
    required String password,
    required String confPassword,
    required String phone,
    required File idCard,
  });

  Future<Either<Failure, String>> resetPassword({
    required String email,
  });
}
