part of 'fetch_drugs_cubit.dart';

@immutable
sealed class FetchDrugsState {}

final class FetchDrugsInitial extends FetchDrugsState {}

final class FetchDrugsLoading extends FetchDrugsState {}

final class FetchDrugsFailure extends FetchDrugsState {
  final String errMesage;

  FetchDrugsFailure({required this.errMesage});
}

final class FetchDrugsSuccess extends FetchDrugsState {
  final List<DrugModel> drugs;

  FetchDrugsSuccess({required this.drugs});
}
