import 'dart:io';

import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:pharmygo/patient/models/patient_model.dart';
import 'package:pharmygo/patient/repos/patients_repo/patients_repo.dart';

part 'update_patient_profile_state.dart';

class UpdatePatientProfileCubit extends Cubit<UpdatePatientProfileState> {
  final PatientsRepo patientsRepo;
  UpdatePatientProfileCubit(this.patientsRepo)
      : super(UpdatePatientProfileInitial());
  Future<void> updatePatient({
     String? name,
     String? email,
     String? password,
     String? confPassword,
     String? phone,
     File? profileImage,
  }) async {
    emit(UpdatePatientLoading());
    var result = await patientsRepo.updatePatient(name: name!, phone: phone!,profileImage: profileImage);

    result.fold((failure) {
      emit(
        UpdatePatientFailure(errMessage: failure.errMessage),
      );
    }, (patientModel) {
    
      emit(UpdatePatientSuccess(patient: patientModel));
    });
  }
}
