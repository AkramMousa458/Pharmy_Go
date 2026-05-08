part of 'delete_medicine_cubit.dart';

@immutable
sealed class DeleteMedicineState {}

final class DeleteMedicineInitial extends DeleteMedicineState {}

final class DeleteMedicineLoading extends DeleteMedicineState {}

final class DeleteMedicineSucssess extends DeleteMedicineState {}

final class DeleteMedicineFailure extends DeleteMedicineState {
  final String errMessage;

  DeleteMedicineFailure({required this.errMessage});
}
