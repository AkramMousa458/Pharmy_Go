import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmygo/core/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repos/auth_repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  final AuthRepo authRepo;

  int _id = 0;
  bool isHidden = true;

  Future<void> loginUser(
      {required email, required password, required userType}) async {
    emit(AuthLoading());
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var result = await authRepo.loginUser(
        email: email, password: password, userType: userType);
    result.fold((failure) {
      emit(
        AuthFailure(errMessage: failure.errMessage),
      );
    }, (authModel) {
      _id = authModel.id;
      prefs.setInt('auth-id', _id);
      prefs.setString('type', userType);
      emit(AuthSuccess());
    });
  }

  Future<void> signupPatient({
    required String name,
    required String email,
    required String password,
    required String confPassword,
    required String phone,
  }) async {
    emit(AuthLoading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = await authRepo.signupPatient(
      name: name,
      email: email,
      password: password,
      confPassword: confPassword,
      phone: phone,
    );

    CollectionReference patients =
        FirebaseFirestore.instance.collection(kPatientsCollection);

    patients.add({
      'email': email,
      'name': name,
      'photo':
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      'phone': phone,
    });
    result.fold((failure) {
      emit(
        AuthFailure(errMessage: failure.errMessage),
      );
    }, (authModel) {
      _id = authModel.id;
      prefs.setInt('auth-id', _id);
      emit(AuthSuccess());
    });
  }

  Future<void> signupPharmacist({
    required String name,
    required String email,
    required String password,
    required String confPassword,
    required String phone,
    required File idCard,
  }) async {
    emit(AuthLoading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = await authRepo.signupPharmacist(
        name: name,
        email: email,
        password: password,
        confPassword: confPassword,
        phone: phone,
        idCard: idCard);

    CollectionReference pharmacists =
        FirebaseFirestore.instance.collection(kPharmacistesCollection);

    pharmacists.add({
      'email': email,
      'name': name,
      'photo':
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      'phone': phone,
    });

    result.fold((failure) {
      emit(
        AuthFailure(errMessage: failure.errMessage),
      );
    }, (authModel) {
      _id = authModel.id;
      prefs.setInt('auth-id', _id);
      emit(AuthSuccess());
    });
  }

  void hidePassword() {
    isHidden = !isHidden;
    isHidden ? emit(PasswordHidenState()) : emit(PasswordShowenState());
  }

  void logout() async {
    emit(LogoutLoading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('auth-id');
    isHidden = !isHidden;
    isHidden ? emit(PasswordHidenState()) : emit(PasswordShowenState());
  }

  void reserPassword({required String email}) async {
    emit(AuthLoading());

    var result = await authRepo.resetPassword(email: email);
    result.fold((failure) {
      emit(
        AuthFailure(errMessage: failure.errMessage),
      );
    }, (message) {
      emit(AuthSuccess());
    });
  }
}
