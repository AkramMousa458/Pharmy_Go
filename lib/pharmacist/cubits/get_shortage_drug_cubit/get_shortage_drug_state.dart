part of 'get_shortage_drug_cubit.dart';

@immutable
sealed class GetShortageDrugState {}

final class GetShortageDrugInitial extends GetShortageDrugState {}
final class GetShortageDrugLoading extends GetShortageDrugState {}
final class GetShortageDrugSuccsess extends GetShortageDrugState {
  final List<ShortageDrugModel> shortageDrugs;
  GetShortageDrugSuccsess({required this.shortageDrugs});
}
final class GetShortageDrugFailure extends GetShortageDrugState {
  final String errMessage;
  GetShortageDrugFailure({required this.errMessage});
}
