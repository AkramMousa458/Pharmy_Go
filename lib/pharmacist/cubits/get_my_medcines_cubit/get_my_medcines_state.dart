part of 'get_my_medcines_cubit.dart';

@immutable
sealed class GetMyMedcinesState {}

final class GetMyMedcinesInitial extends GetMyMedcinesState {}
final class GetMyMedcinesLoading extends GetMyMedcinesState {}
final class GetMyMedcinesSuccsess extends GetMyMedcinesState {
  final List<DrugModel> myMedcines;
  GetMyMedcinesSuccsess({required this.myMedcines});
}
final class GetMyMedcinesFailure extends GetMyMedcinesState {
  final String errMessage;
  GetMyMedcinesFailure({required this.errMessage});
}
