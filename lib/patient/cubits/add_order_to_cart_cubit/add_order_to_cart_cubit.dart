import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pharmygo/patient/repos/patients_repo/patients_repo.dart';

part 'add_order_to_cart_state.dart';

class AddOrderToCartCubit extends Cubit<AddOrderToCartState> {
  AddOrderToCartCubit(this.patientsRepo) : super(AddOrderToCartInitial());
  final PatientsRepo patientsRepo;

  Future<void> addOrderToCart(
      {required int pharmacyId,
      required int drugId,
      required int quantity}) async {
    emit(AddOrderToCartLoading());

    var result = await patientsRepo.addOrderToCart(
      pharmacyId: pharmacyId,
      drugId: drugId,
      quantity: quantity,
    );

    result.fold((failure) {
      emit(AddOrderToCartFailure(errMessgae: failure.toString()));
    }, (message) {
      emit(AddOrderToCartSuccsess());
    });
  }
}
