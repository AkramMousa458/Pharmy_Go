import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmygo/pharmacist/repos/pharmacist_repo/pharmacist_repo.dart';

part 'add_medcine_state.dart';

class AddMedcineCubit extends Cubit<AddMedcineState> {
  AddMedcineCubit(this.pharmacistRepo) : super(AddMedcineInitial());
  final PharmacistRepo pharmacistRepo;
  Future<void> addMedcine({
    required int pharmacyId,
    required int drugId,
    required int quantity,
  }) async {
    emit(AddMedcineLoading());
    var result = await pharmacistRepo.addMedicine(
        pharmacyId: pharmacyId, drugId: drugId, quantity: quantity);

    result.fold((failure) {
      emit(
        AddMedcineFailure(
          errMessage: failure.errMessage,
        ),
      );
    }, (pharmacist) {
      emit(AddMedcineSuccess());
    });
  }
}
