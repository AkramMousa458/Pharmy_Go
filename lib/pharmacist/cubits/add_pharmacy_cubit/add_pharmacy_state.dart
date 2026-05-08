part of 'add_pharmacy_cubit.dart';

@immutable
sealed class AddPharmacyState {}

final class AddPharmacyInitial extends AddPharmacyState {}
final class AddPharmacyLoading extends AddPharmacyState {}

final class AddPharmacySuccess extends AddPharmacyState {}

final class AddPharmacyFailure extends AddPharmacyState {
  final String errMessage;

  AddPharmacyFailure({required this.errMessage});
}
