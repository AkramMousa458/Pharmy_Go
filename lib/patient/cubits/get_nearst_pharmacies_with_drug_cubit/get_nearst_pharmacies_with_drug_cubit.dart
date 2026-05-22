import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pharmygo/patient/repos/patients_repo/patients_repo.dart';
import 'package:pharmygo/pharmacist/models/nearst_pharmacy_model.dart';

part 'get_nearst_pharmacies_with_drug_state.dart';

class GetNearstPharmciesWithDrugCubit
    extends Cubit<GetNearstPharmciesWithDrugState> {
  GetNearstPharmciesWithDrugCubit(this.patientsRepo)
      : super(GetNearstPharmciesWithDrugInitial());
  final PatientsRepo patientsRepo;
  // List<PharmacyModel> nearstPharmacies = [];

  Future<void> getNearstPharmaciesWithDrug({required int drugId}) async {
    emit(GetNearstPharmciesWithDrugLoading());
    var result = await patientsRepo.getNearstPharmaciesWithDrug(drugId: drugId);
    result.fold((failure) {
      emit(GetNearstPharmciesWithDrugFailure(errMessage: failure.toString()));
    }, (pharmacies) {
      // nearstPharmacies.clear();
      // nearstPharmacies.addAll(pharmacies);
      List<NearestPharmacyModel> nearstPharmacies = [];
      for (var element in pharmacies) {
        if (element.distance <= 10000) {
          nearstPharmacies.add(element);
        }
      }
      nearstPharmacies.sort(
        (a, b) => a.distance.compareTo(b.distance),
      );
      emit(GetNearstPharmciesWithDrugSuccsess(
          nearstPharmacies: nearstPharmacies));
    });
  }
}
