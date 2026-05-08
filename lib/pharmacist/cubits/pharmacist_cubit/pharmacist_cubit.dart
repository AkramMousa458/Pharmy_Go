// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmygo/pharmacist/models/pharmacist_model.dart';
import 'package:pharmygo/pharmacist/repos/pharmacist_repo/pharmacist_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pharmacist_state.dart';

class PharmacistCubit extends Cubit<PharmacistState> {
  PharmacistCubit(this.homeRepo) : super(PharmacistInitial());
  final PharmacistRepo homeRepo;
  PharmacistModel? pharmacist;
  Future<void> getPharmaicst() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emit(FetchPharmacistLoading());
    var result = await homeRepo.getPharmacist();
    result.fold((failure) {
      emit(FetchPharmacistFailure(errMesage: failure.toString()));
    }, (pharmacist) {
      this.pharmacist = pharmacist;
       prefs.setInt("id", pharmacist.id);
      emit(FetchPharmacistSuccess(pharmacist: pharmacist));
    });
  }
}
