part of 'add_medcine_cubit.dart';

@immutable
sealed class AddMedcineState {}

final class AddMedcineInitial extends AddMedcineState {}

final class AddMedcineLoading extends AddMedcineState {}

final class AddMedcineSuccess extends AddMedcineState {}

final class AddMedcineFailure extends AddMedcineState {
  final String errMessage;

  AddMedcineFailure({required this.errMessage});
}
