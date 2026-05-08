part of 'get_nearst_pharmacies_with_drug_cubit.dart';

@immutable
sealed class GetNearstPharmciesWithDrugState {}

final class GetNearstPharmciesWithDrugInitial
    extends GetNearstPharmciesWithDrugState {}

final class GetNearstPharmciesWithDrugLoading
    extends GetNearstPharmciesWithDrugState {}

final class GetNearstPharmciesWithDrugSuccsess
    extends GetNearstPharmciesWithDrugState {
  final List<NearestPharmacyModel> nearstPharmacies;
  GetNearstPharmciesWithDrugSuccsess({required this.nearstPharmacies});
}

final class GetNearstPharmciesWithDrugFailure
    extends GetNearstPharmciesWithDrugState {
  final String errMessage;
  GetNearstPharmciesWithDrugFailure({required this.errMessage});
}
