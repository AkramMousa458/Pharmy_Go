part of 'quantity_counter_cubit.dart';

@immutable
sealed class QuantityCounterState {}

final class QuantityCounterInitial extends QuantityCounterState {}
final class QuantityCounterIncreased extends QuantityCounterState {
  final int quantity;
  QuantityCounterIncreased({required this.quantity});
}
final class QuantityCounterDecreased extends QuantityCounterState {
    final int quantity;
  QuantityCounterDecreased({required this.quantity});
}
