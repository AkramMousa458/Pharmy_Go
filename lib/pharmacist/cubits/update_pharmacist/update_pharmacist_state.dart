part of 'update_pharmacist_cubit.dart';

@immutable
sealed class UpdatePharmacistState {}

final class UpdatePharmacistInitial extends UpdatePharmacistState {}
final class UpdatePharmacistLoading extends UpdatePharmacistState {}

final class UpdatePharmacistFailure extends UpdatePharmacistState {
  final String errMessage;

  UpdatePharmacistFailure({required this.errMessage});
}

final class UpdatePharmacistSuccess extends UpdatePharmacistState {
  final PharmacistModel pharmacist;

  UpdatePharmacistSuccess({required this.pharmacist});
}