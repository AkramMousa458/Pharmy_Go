part of 'switch_cubit.dart';

@immutable
sealed class SwitchState {}

final class SwitchInitial extends SwitchState {}

final class SwitchToLightMode extends SwitchState {}

final class SwitchToDarkMode extends SwitchState {}

final class SwitchToEn extends SwitchState {}

final class SwitchToAr extends SwitchState {}
