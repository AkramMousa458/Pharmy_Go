part of 'get_nearst_pharmacies_cubit.dart';

@immutable
sealed class GetNearstPharmaciesState {}

final class GetNearstPharmaciesInitial extends GetNearstPharmaciesState {}

final class GetNearstPharmaciesLoading
    extends GetNearstPharmaciesState {}

final class GetNearstPharmaciesSuccsess
    extends GetNearstPharmaciesState {
  final List<NearestPharmacyModel> nearstPharmacies;
  GetNearstPharmaciesSuccsess({required this.nearstPharmacies});
}

final class GetNearstPharmaciesFailure
    extends GetNearstPharmaciesState {
  final String errMessage;
  GetNearstPharmaciesFailure({required this.errMessage});
}