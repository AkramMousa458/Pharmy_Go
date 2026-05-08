import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pharmygo/pharmacist/models/pharmacy_model.dart';
import 'package:pharmygo/pharmacist/repos/pharmacist_repo/pharmacist_repo.dart';

part 'get_my_pharmacies_state.dart';

class GetMyPharmaciesCubit extends Cubit<GetMyPharmaciesState> {
  GetMyPharmaciesCubit(this.pharmacistRepo) : super(GetMyPharmaciesInitial());
  final PharmacistRepo pharmacistRepo;
  List<PharmacyModel> myPharmacies = [];
  PharmacyModel choosenPharmacy = PharmacyModel(
      id: 0,
      pharmacistId: 0,
      delivery: 0,
      pharmacyName: '',
      longitude: 0,
      latitude: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now());

  Future<void> getMyPharmacies() async {
    emit(GetMyPharmaciesLoading());
    var result = await pharmacistRepo.getMyPharmacies();
    result.fold((failure) {
      emit(GetMyPharmaciesFailure(errMessage: failure.toString()));
    }, (pharmacies) {
      myPharmacies.clear();
      myPharmacies.addAll(pharmacies);
      if (myPharmacies.isNotEmpty) {
        choosenPharmacy = myPharmacies.first;
      } else {
        choosenPharmacy = PharmacyModel(
            id: 0,
            delivery: 0,
            pharmacistId: 0,
            pharmacyName: 'No pharmacies yet',
            longitude: 0,
            latitude: 0,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now());
      }

      emit(GetMyPharmaciesSuccsess(myPharmacies: pharmacies));
    });
  }
}
