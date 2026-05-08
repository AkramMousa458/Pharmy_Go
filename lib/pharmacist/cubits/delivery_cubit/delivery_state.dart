part of 'delivery_cubit.dart';

@immutable
sealed class DeliveryState {}

final class DeliveryInitial extends DeliveryState {}
final class DeliveryYes extends DeliveryState {}
final class DeliveryNo extends DeliveryState {}
