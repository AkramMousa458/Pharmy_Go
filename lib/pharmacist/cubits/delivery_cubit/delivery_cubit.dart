import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delivery_state.dart';

class DeliveryCubit extends Cubit<DeliveryState> {
  bool delivery = false;
  DeliveryCubit() : super(DeliveryInitial());
  void setDelivery(bool delivery) {
    this.delivery = delivery;
    if (this.delivery) {
      emit(DeliveryYes());
    } else {
      emit(DeliveryNo());
    }
  }
}
