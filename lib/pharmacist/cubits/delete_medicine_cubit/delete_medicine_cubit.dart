import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmygo/pharmacist/repos/pharmacist_repo/pharmacist_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'delete_medicine_state.dart';

class DeleteMedicineCubit extends Cubit<DeleteMedicineState> {
  DeleteMedicineCubit(this.pharmacistRepo) : super(DeleteMedicineInitial());
  final PharmacistRepo pharmacistRepo;
  Future<void> deleteMedicine(
      { required int drugId, int? pharmacyId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int pharmacyId = prefs.getInt("id")??0;
    emit(DeleteMedicineLoading());
    var result = await pharmacistRepo.deleteMedicine(
        pharmacyId: pharmacyId, drugId: drugId);
    result.fold((failure) {
      emit(DeleteMedicineFailure(errMessage: failure.toString()));
    }, (message) {
      emit(DeleteMedicineSucssess());
    });
  }
}
