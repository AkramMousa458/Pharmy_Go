import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmygo/pharmacist/repos/pharmacist_repo/pharmacist_repo.dart';
part 'delete_order_state.dart';

class DeleteOrderCubit extends Cubit<DeleteOrderState> {
  DeleteOrderCubit(this.pharmacistRepo) : super(DeleteOrderInitial());
  final PharmacistRepo pharmacistRepo;
  Future<void> deleteOrder(
      {required int patientId, required int orderId}) async {
    emit(DeleteOrderLoading());
    var result = await pharmacistRepo.deleteOrder(
        patientId: patientId, orderId: orderId);
    result.fold((failure) {
      emit(DeleteOrderFailure(errMessage: failure.toString()));
    }, (message) {
      emit(DeleteOrderSucssess());
    });
  }
}
