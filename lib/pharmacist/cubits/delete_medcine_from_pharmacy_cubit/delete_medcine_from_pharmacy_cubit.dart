import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmygo/pharmacist/repos/pharmacist_repo/pharmacist_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'delete_medcine_from_pharmacy_state.dart';

class DeleteMedcineFromPharmacyCubit
    extends Cubit<DeleteMedcineFromPharmacyState> {
  DeleteMedcineFromPharmacyCubit(this.pharmacistRepo)
      : super(DeleteOrderFromCartInitial());
  final PharmacistRepo pharmacistRepo;

  Future<void> deleteMedcine({required int drugId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int pharmacyId = prefs.getInt("id")??0;
    emit(DeleteOrderFromCartLoading());
    var result = await pharmacistRepo.deleteMedicine(
        drugId: drugId, pharmacyId: pharmacyId);
    result.fold((failure) {
      emit((DeleteOrderFromCartFailure(errMessage: failure.toString())));
    }, (message) {
      emit(DeleteOrderFromCartSuccsess(message: message));
    });
  }
}
