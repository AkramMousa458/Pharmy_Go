part of 'update_patient_profile_cubit.dart';

@immutable
sealed class UpdatePatientProfileState {}

final class UpdatePatientProfileInitial extends UpdatePatientProfileState {}

final class UpdatePatientLoading extends UpdatePatientProfileState {}

final class UpdatePatientFailure extends UpdatePatientProfileState {
  final String errMessage;

  UpdatePatientFailure({required this.errMessage});
}

final class UpdatePatientSuccess extends UpdatePatientProfileState {
  final PatientModel patient;

  UpdatePatientSuccess({required this.patient});
}
