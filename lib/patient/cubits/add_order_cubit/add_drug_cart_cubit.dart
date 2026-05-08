import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pharmygo/patient/repos/patients_repo/patients_repo.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  AddOrderCubit(this.patientsRepo) : super(AddOrderInitial());
  final PatientsRepo patientsRepo;

  Future<void> addOrder(
      {required int pharmacyId,
      required int drugId,
      required int quantity}) async {
    emit(AddOrderLoading());

    var result = await patientsRepo.addOrder(
      pharmacyId: pharmacyId,
      drugId: drugId,
      quantity: quantity,
    );

    result.fold((failure) {
      emit(AddOrderFailure(errMessgae: failure.toString()));
    }, (message) {
      emit(AddOrderSuccsess());
    });
  }
}
