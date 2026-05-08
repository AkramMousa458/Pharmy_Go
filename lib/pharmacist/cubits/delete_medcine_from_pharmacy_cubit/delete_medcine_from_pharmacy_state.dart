part of 'delete_medcine_from_pharmacy_cubit.dart';

@immutable
sealed class DeleteMedcineFromPharmacyState {}

final class DeleteOrderFromCartInitial extends DeleteMedcineFromPharmacyState {}

final class DeleteOrderFromCartLoading extends DeleteMedcineFromPharmacyState {}

final class DeleteOrderFromCartSuccsess extends DeleteMedcineFromPharmacyState {
  final String message;
  DeleteOrderFromCartSuccsess({required this.message});
}

final class DeleteOrderFromCartFailure extends DeleteMedcineFromPharmacyState {
  final String errMessage;
  DeleteOrderFromCartFailure({required this.errMessage});
}
