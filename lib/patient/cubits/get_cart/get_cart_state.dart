part of 'get_cart_cubit.dart';

@immutable
sealed class GetCartState {}

final class GetCartInitial extends GetCartState {}

final class GetCartLoading extends GetCartState {}

final class GetCartSuccsess extends GetCartState {
  final List<OrderModel> ordersList;
  GetCartSuccsess({required this.ordersList});
}

final class GetCartFailure extends GetCartState {
  final String errMessage;
  GetCartFailure({required this.errMessage});
}
