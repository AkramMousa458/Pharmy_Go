part of 'delete_order_from_cart_cubit.dart';

@immutable
sealed class DeleteOrderFromCartState {}

final class DeleteOrderFromCartInitial extends DeleteOrderFromCartState {}

final class DeleteOrderFromCartLoading extends DeleteOrderFromCartState {}

final class DeleteOrderFromCartSuccsess extends DeleteOrderFromCartState {
  final String message;
  DeleteOrderFromCartSuccsess({required this.message});
}

final class DeleteOrderFromCartFailure extends DeleteOrderFromCartState {
  final String errMessage;
  DeleteOrderFromCartFailure({required this.errMessage});
}
