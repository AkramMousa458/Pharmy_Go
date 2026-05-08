import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'select_type_state.dart';

class SelectTypeCubit extends Cubit<SelectTypeState> {
  SelectTypeCubit() : super(SelectTypeInitial());

  void changeType({required String type}) {
    if (type.toLowerCase() == "patient") {
      emit(SelectTypePatient());
    } else if (type.toLowerCase() == "pharmacist") {
      emit(SelectTypePharmacist());
    }
  }
}
