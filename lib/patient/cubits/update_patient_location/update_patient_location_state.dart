part of 'update_patient_location_cubit.dart';

@immutable
sealed class UpdatePatientLocationState {}

final class UpdatePatientLocationInitial extends UpdatePatientLocationState {}

final class UpdatePatientLocationLoading extends UpdatePatientLocationState {}

final class UpdatePatientLocationSuccsess extends UpdatePatientLocationState {}

final class UpdatePatientLocationFailure extends UpdatePatientLocationState {
  final String errMessage;
  UpdatePatientLocationFailure({required this.errMessage});
}
