part of 'add_drug_cart_cubit.dart';

@immutable
sealed class AddOrderState {}

final class AddOrderInitial extends AddOrderState {}
final class AddOrderLoading extends AddOrderState {}
final class AddOrderSuccsess extends AddOrderState {}
final class AddOrderFailure extends AddOrderState {
  final String errMessgae;
  AddOrderFailure({required this.errMessgae});
}
