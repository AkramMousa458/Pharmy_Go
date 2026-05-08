import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmygo/pharmacist/models/pharmacy_orders_model.dart';
import 'package:pharmygo/pharmacist/repos/pharmacist_repo/pharmacist_repo.dart';

part 'get_pharmacy_orders_state.dart';

class GetPharmacyOrdersCubit extends Cubit<GetPharmacyOrdersState> {
  GetPharmacyOrdersCubit(this.pharmacistRepo) : super(GetPharmacyOrdersInitial());
  final PharmacistRepo pharmacistRepo;

  Future<void> getPharmacyOrders({required int pharmacyId}) async {
    emit(GetPharmacyOrdersLoading());
    var result = await pharmacistRepo.getPharmacyOrders(pharmacyId: pharmacyId);
    result.fold((failure) {
      emit(GetPharmacyOrdersFailure(errMessage: failure.toString()));
    }, (orders) {
      emit(GetPharmacyOrdersSuccsess(ordersList: orders));
    });
  }
}
