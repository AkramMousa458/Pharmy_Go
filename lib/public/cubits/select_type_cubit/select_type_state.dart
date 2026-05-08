part of 'select_type_cubit.dart';

@immutable
sealed class SelectTypeState {}

final class SelectTypeInitial extends SelectTypeState {}
final class SelectTypePatient extends SelectTypeState {}
final class SelectTypePharmacist extends SelectTypeState {}
