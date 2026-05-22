import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmygo/patient/repos/patients_repo/patients_repo.dart';

part 'delete_order_from_cart_state.dart';

class DeleteOrderFromCartCubit extends Cubit<DeleteOrderFromCartState> {
  DeleteOrderFromCartCubit(this.patientsRepo)
      : super(DeleteOrderFromCartInitial());

  final PatientsRepo patientsRepo;

  Future<void> deleteOrderFromCart({required int orderId}) async {
    if (!isClosed) emit(DeleteOrderFromCartLoading());
    var result = await patientsRepo.deleteOrderFromCart(orderId: orderId);
    result.fold((failure) {
      if (!isClosed) {
        emit(DeleteOrderFromCartFailure(errMessage: failure.toString()));
      }
    }, (message) {
      if (!isClosed) emit(DeleteOrderFromCartSuccsess(message: message));
    });
  }
}
