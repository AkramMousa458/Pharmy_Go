import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmygo/pharmacist/repos/pharmacist_repo/pharmacist_repo.dart';
import 'package:pharmygo/public/models/shortage_drug_model.dart';

part 'get_shortage_drug_state.dart';

class GetShortageDrugCubit extends Cubit<GetShortageDrugState> {
  GetShortageDrugCubit(this.pharmacistRepo) : super(GetShortageDrugInitial());
  final PharmacistRepo pharmacistRepo;
  List<ShortageDrugModel> shortageDrugs = [];
  Future<void> getShortageDrugs({required int pharmacyId}) async {
    emit(GetShortageDrugLoading());
    var result = await pharmacistRepo.getShortageDrugs(pharmacyId: pharmacyId);
    result.fold((failure) {
      emit(GetShortageDrugFailure(errMessage: failure.toString()));
    }, (drugs) {
      shortageDrugs.clear();
      shortageDrugs.addAll(drugs);
      emit(GetShortageDrugSuccsess(shortageDrugs: drugs));
    });
  }
}
