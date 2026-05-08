import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'quantity_counter_state.dart';

class QuantityCounterCubit extends Cubit<QuantityCounterState> {
  QuantityCounterCubit() : super(QuantityCounterInitial());
  int quantity = 1;

  void increaseQuantity(){
    if(quantity<99) quantity++;
    emit(QuantityCounterIncreased(quantity: quantity));
  }

  void decreaseQuantity(){
    if(quantity>1) quantity--;
    emit(QuantityCounterDecreased(quantity: quantity));
  }
}
