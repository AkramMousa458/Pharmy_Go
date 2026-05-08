part of 'get_my_pharmacies_cubit.dart';

@immutable
sealed class GetMyPharmaciesState {}

final class GetMyPharmaciesInitial extends GetMyPharmaciesState {}
final class GetMyPharmaciesLoading extends GetMyPharmaciesState {}
final class GetMyPharmaciesSuccsess extends GetMyPharmaciesState {
  final List<PharmacyModel> myPharmacies;
  GetMyPharmaciesSuccsess({required this.myPharmacies});
}
final class GetMyPharmaciesFailure extends GetMyPharmaciesState {
  final String errMessage;
  GetMyPharmaciesFailure({required this.errMessage});
}
