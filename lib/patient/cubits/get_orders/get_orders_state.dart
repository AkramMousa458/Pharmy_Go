part of 'get_orders_cubit.dart';

@immutable
sealed class GetOrdersState {}

final class GetOrdersInitial extends GetOrdersState {}

final class GetOrdersLoading extends GetOrdersState {}

final class GetOrdersSuccsess extends GetOrdersState {
  final List<OrderModel> ordersList;
  GetOrdersSuccsess({required this.ordersList});
}

final class GetOrdersFailure extends GetOrdersState {
  final String errMessage;
  GetOrdersFailure({required this.errMessage});
}
