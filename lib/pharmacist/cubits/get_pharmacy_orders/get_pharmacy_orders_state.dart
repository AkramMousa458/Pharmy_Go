part of 'get_pharmacy_orders_cubit.dart';

@immutable
sealed class GetPharmacyOrdersState {}

final class GetPharmacyOrdersInitial extends GetPharmacyOrdersState {}

final class GetPharmacyOrdersLoading extends GetPharmacyOrdersState {}

final class GetPharmacyOrdersSuccsess extends GetPharmacyOrdersState {
  final List<PharmacyOrderModel> ordersList;
  GetPharmacyOrdersSuccsess({required this.ordersList});
}

final class GetPharmacyOrdersFailure extends GetPharmacyOrdersState {
  final String errMessage;
  GetPharmacyOrdersFailure({required this.errMessage});
}
