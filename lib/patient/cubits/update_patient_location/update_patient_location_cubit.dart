import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmygo/patient/repos/patients_repo/patients_repo.dart';

part 'update_patient_location_state.dart';

class UpdatePatientLocationCubit extends Cubit<UpdatePatientLocationState> {
  UpdatePatientLocationCubit(this.patientsRepo) : super(UpdatePatientLocationInitial());

  final PatientsRepo patientsRepo;
  Future<void> updatePatientLocation({
      required String longitude,
    required String latitude,
  }) async {
    emit(UpdatePatientLocationLoading());
    var result = await patientsRepo.updatePatientLocation(longitude: longitude, latitude: latitude);

    result.fold((failure) {
      emit(
        UpdatePatientLocationFailure(errMessage: failure.errMessage),
      );
    }, (message) {
      emit(UpdatePatientLocationSuccsess());
    });
  }
}
