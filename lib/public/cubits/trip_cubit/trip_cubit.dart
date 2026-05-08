import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'trip_state.dart';

class TripCubit extends Cubit<TripState> {
  TripCubit() : super(TripInitial());
  bool trip = false;
  double latitude = 0, longitude = 0;
  void startTrip({latitude, longitude}) {
    trip = true;
    this.latitude = latitude;
    this.longitude = longitude;
    emit(TripSuccess());
  }
}
