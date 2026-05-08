import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmygo/patient/repos/patients_repo/patients_repo.dart';
import 'package:pharmygo/public/models/order_model.dart';

part 'get_cart_state.dart';

class GetCartCubit extends Cubit<GetCartState> {
  GetCartCubit(this.patientsRepo) : super(GetCartInitial());
  final PatientsRepo patientsRepo;
  List<OrderModel> ordersList = [];

  Future<void> getCart() async {
    emit(GetCartLoading());
    var result = await patientsRepo.getCart();
    result.fold((failure) {
      emit(GetCartFailure(errMessage: failure.toString()));
    }, (orders) {
      ordersList.clear();
      ordersList.addAll(orders);
      emit(GetCartSuccsess(ordersList: orders));
    });
  }
}
