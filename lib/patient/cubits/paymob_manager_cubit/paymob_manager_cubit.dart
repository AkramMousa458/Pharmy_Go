import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmygo/patient/repos/paymob_manager_repo/paymob_manager_repo.dart';
part 'paymob_manager_state.dart';

class PaymobManagerCubit extends Cubit<PaymobManagerState> {
  PaymobManagerCubit(this.paymobManagerRepo) : super(PaymobManagerInitial());
  final PaymobManagerRepo paymobManagerRepo;
  static PaymobManagerCubit get(context) => BlocProvider.of(context);

  String _authanticationToken = '';
  String _orderId = '';
  String paymentKey = '';

  Future<String> getPaymentKey({
    required int amountCents,
    required String currency,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
  }) async {
    amountCents *= 100;
    await _getAuthanticationToken();
    await _getOrderId(
      authToken: _authanticationToken,
      deliveryNeeded: false,
      amountCents: amountCents.toString(),
      currency: currency,
    );

    await _getAcceptancePaymentKey(
      authToken: _authanticationToken,
      amountCents: amountCents.toString(),
      orderId: _orderId,
      currency: currency,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
    );

    return paymentKey;
  }

  Future<void> _getAuthanticationToken() async {
    emit(PaymobManagerLoading());
    var result = await paymobManagerRepo.getAuthanticationToken();
    result.fold((failure) {
      emit(PaymobManagerFailure(errMessage: failure.errMessage));
    }, (result) {
      emit(PaymobManagerSusccsess());
      _authanticationToken = result;
    });
  }

  Future<void> _getOrderId({
    required String authToken,
    required bool deliveryNeeded,
    required String amountCents,
    required String currency,
  }) async {
    emit(PaymobManagerLoading());
    var result = await paymobManagerRepo.getOrderId(
      authToken: authToken,
      deliveryNeeded: deliveryNeeded,
      amountCents: amountCents,
      currency: currency,
    );

    result.fold((failure) {
      emit(PaymobManagerFailure(errMessage: failure.errMessage));
    }, (result) {
      emit(PaymobManagerSusccsess());
      _orderId = result.toString();
    });
  }

  Future<void> _getAcceptancePaymentKey({
    required String authToken,
    required String amountCents,
    required String orderId,
    required String currency,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
  }) async {
    emit(PaymobManagerLoading());
    var result = await paymobManagerRepo.getAcceptancePaymentKey(
      authToken: authToken,
      amountCents: amountCents,
      orderId: orderId,
      currency: currency,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
    );

    result.fold((failure) {
      emit(PaymobManagerFailure(errMessage: failure.errMessage));
    }, (result) {
      emit(PaymobManagerSusccsess());
      paymentKey = result;
    });
  }
}
