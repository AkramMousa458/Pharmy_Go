import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmygo/patient/repos/patients_repo/patients_repo.dart';
import 'package:pharmygo/public/models/order_model.dart';

part 'get_orders_state.dart';

class GetOrdersCubit extends Cubit<GetOrdersState> {
  GetOrdersCubit(this.patientsRepo) : super(GetOrdersInitial());
  final PatientsRepo patientsRepo;

  Future<void> getOrders() async {
    emit(GetOrdersLoading());
    var result = await patientsRepo.getOrders();
    result.fold((failure) {
      emit(GetOrdersFailure(errMessage: failure.toString()));
    }, (orders) {
      emit(GetOrdersSuccsess(ordersList: orders));
    });
  }
}
