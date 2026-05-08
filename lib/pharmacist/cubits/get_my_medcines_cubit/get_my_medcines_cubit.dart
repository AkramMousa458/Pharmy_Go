import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmygo/pharmacist/repos/pharmacist_repo/pharmacist_repo.dart';
import 'package:pharmygo/public/models/drug_model.dart';

part 'get_my_medcines_state.dart';

class GetMyMedcinesCubit extends Cubit<GetMyMedcinesState> {
  GetMyMedcinesCubit(this.pharmacistRepo) : super(GetMyMedcinesInitial());
  final PharmacistRepo pharmacistRepo;
  List<DrugModel> myDrugs = [];
  Future<void> getMyMedcines({required int pharmacyId}) async {
    emit(GetMyMedcinesLoading());
    var result = await pharmacistRepo.getMyMedcines(pharmacyId: pharmacyId);
    result.fold((failure) {
      emit(GetMyMedcinesFailure(errMessage: failure.toString()));
    }, (drugs) {
      myDrugs.clear();
      myDrugs.addAll(drugs);
      emit(GetMyMedcinesSuccsess(myMedcines: drugs));
    });
  }
}
