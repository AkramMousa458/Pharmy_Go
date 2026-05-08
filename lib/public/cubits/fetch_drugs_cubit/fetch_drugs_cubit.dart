import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pharmygo/public/models/drug_model.dart';
import 'package:pharmygo/public/repos/drugs_repo/drugs_repo.dart';

part 'fetch_drugs_state.dart';

class FetchDrugsCubit extends Cubit<FetchDrugsState> {
  FetchDrugsCubit(this.homeRepo) : super(FetchDrugsInitial());
  final DrugsRepo homeRepo;
  List<DrugModel> drugsList = [];
  Future<void> fetchDrugs() async {
    emit(FetchDrugsLoading());
    var result = await homeRepo.fetchDrugs();
    result.fold((failure) {
      emit(FetchDrugsFailure(errMesage: failure.toString()));
    }, (drugs) {
      drugsList.addAll(drugs);
      emit(FetchDrugsSuccess(drugs: drugs));
    });
  }
}
