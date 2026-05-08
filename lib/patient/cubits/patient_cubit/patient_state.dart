part of 'patient_cubit.dart';

@immutable
sealed class PatientState {}

final class PatientInitial extends PatientState {}
final class FetchPatientLoading extends PatientState {}

final class FetchPatientFailure extends PatientState {
  final String errMesage;

  FetchPatientFailure({required this.errMesage});
}

final class FetchPatientSuccess extends PatientState {
  final PatientModel patient;

  FetchPatientSuccess({required this.patient});
}
