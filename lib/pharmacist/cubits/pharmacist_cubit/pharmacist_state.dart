part of 'pharmacist_cubit.dart';

@immutable
sealed class PharmacistState {}

final class PharmacistInitial extends PharmacistState {}

final class FetchPharmacistLoading extends PharmacistState {}

final class FetchPharmacistFailure extends PharmacistState {
  final String errMesage;

  FetchPharmacistFailure({required this.errMesage});
}

final class FetchPharmacistSuccess extends PharmacistState {
  final PharmacistModel pharmacist;

  FetchPharmacistSuccess({required this.pharmacist});
}
