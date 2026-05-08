import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmygo/patient/repos/patients_repo/patients_repo.dart';
import 'package:pharmygo/pharmacist/models/nearst_pharmacy_model.dart';

part 'get_nearst_pharmacies_state.dart';

class GetNearstPharmaciesCubit extends Cubit<GetNearstPharmaciesState> {
  GetNearstPharmaciesCubit(this.patientsRepo) : super(GetNearstPharmaciesInitial());
    final PatientsRepo patientsRepo;
  List<NearestPharmacyModel> nearstPharmacies = [];

  Future<void> getNearstPharmacies() async {
    emit(GetNearstPharmaciesLoading());
    var result = await patientsRepo.getNearstPharmacies();
    result.fold((failure) {
      emit(GetNearstPharmaciesFailure(errMessage: failure.toString()));
    }, (pharmacies) {
      nearstPharmacies.clear();
      nearstPharmacies.addAll(pharmacies);
      pharmacies.sort(
        (a, b) => a.distance.compareTo(b.distance),
      );
      emit(GetNearstPharmaciesSuccsess(nearstPharmacies: pharmacies));
    });
  }
}
