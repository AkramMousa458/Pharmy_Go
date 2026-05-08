part of 'add_order_to_cart_cubit.dart';

@immutable
sealed class AddOrderToCartState {}

final class AddOrderToCartInitial extends AddOrderToCartState {}
final class AddOrderToCartLoading extends AddOrderToCartState {}
final class AddOrderToCartSuccsess extends AddOrderToCartState {}
final class AddOrderToCartFailure extends AddOrderToCartState {
  final String errMessgae;
  AddOrderToCartFailure({required this.errMessgae});
}
