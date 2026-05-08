
// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:pharmygo/patient/models/patient_model.dart';
import 'package:pharmygo/patient/repos/patients_repo/patients_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'patient_state.dart';

class PatientCubit extends Cubit<PatientState> {
  PatientCubit(this.homeRepo) : super(PatientInitial());
  final PatientsRepo homeRepo;
  PatientModel? patient;

  Future<void> getPatient() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emit(FetchPatientLoading());
    var result = await homeRepo.getPatient();
    result.fold((failure) {
      emit(FetchPatientFailure(errMesage: failure.toString()));
    }, (patient) {
      this.patient = patient;
      print('Patient Id ${patient.id}');
      log('Patient Id ${patient.id}');
      prefs.setInt("id", patient.id);
      emit(FetchPatientSuccess(patient: patient));
    });
  }
}
