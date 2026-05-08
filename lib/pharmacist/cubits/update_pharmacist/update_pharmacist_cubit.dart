// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmygo/pharmacist/models/pharmacist_model.dart';
import 'package:pharmygo/pharmacist/repos/pharmacist_repo/pharmacist_repo.dart';

part 'update_pharmacist_state.dart';

class UpdatePharmacistCubit extends Cubit<UpdatePharmacistState> {
  final PharmacistRepo pharmacistRepo;
  UpdatePharmacistCubit(this.pharmacistRepo) : super(UpdatePharmacistInitial());
  Future<void> updatePharmacist({
    String? name,
    String? email,
    String? password,
    String? confPassword,
    String? phone,
    File? profileImage,
  }) async {
    emit(UpdatePharmacistLoading());
    var result = await pharmacistRepo.updatePharmacist(
        name: name!, phone: phone!, profileImage: profileImage);

    result.fold((failure) {
      emit(
        UpdatePharmacistFailure(errMessage: failure.errMessage, ),
      );
    }, (pharmacist) {
      emit(UpdatePharmacistSuccess(pharmacist: pharmacist));
    });
  }
}
