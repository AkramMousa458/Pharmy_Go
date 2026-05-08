part of 'delete_order_cubit.dart';

@immutable
sealed class DeleteOrderState {}

final class DeleteOrderInitial extends DeleteOrderState {}

final class DeleteOrderLoading extends DeleteOrderState {}

final class DeleteOrderSucssess extends DeleteOrderState {}

final class DeleteOrderFailure extends DeleteOrderState {
  final String errMessage;

  DeleteOrderFailure({required this.errMessage});
}
