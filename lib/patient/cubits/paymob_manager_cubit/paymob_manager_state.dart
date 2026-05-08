part of 'paymob_manager_cubit.dart';

@immutable
sealed class PaymobManagerState {}

final class PaymobManagerInitial extends PaymobManagerState {}

final class PaymobManagerLoading extends PaymobManagerState {}

final class PaymobManagerFailure extends PaymobManagerState {
  final String errMessage;

  PaymobManagerFailure({required this.errMessage});
}

final class PaymobManagerSusccsess extends PaymobManagerState {}
