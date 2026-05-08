import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmygo/pharmacist/repos/pharmacist_repo/pharmacist_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'add_pharmacy_state.dart';

class AddPharmacyCubit extends Cubit<AddPharmacyState> {
  AddPharmacyCubit(this.pharmacistRepo) : super(AddPharmacyInitial());
  final PharmacistRepo pharmacistRepo;
  Future<void> addPharmacy({
    required int delivery,
    required String pharmacyName,
    required double longitude,
    required double latitude,
  }) async {
  SharedPreferences prefs =await  SharedPreferences.getInstance();
 int id =  prefs.getInt("id")??0;
    emit(AddPharmacyLoading());
    var result = await pharmacistRepo.addPharmacy(
        pharmacyId: id,
        delivery: delivery,
        pharmacyName: pharmacyName,
        longitude: longitude,
        latitude: latitude);

    result.fold((failure) {
      emit(
        AddPharmacyFailure(
          errMessage: failure.errMessage,
        ),
      );
    }, (pharmacist) {
      emit(AddPharmacySuccess());
    });
  }
}
