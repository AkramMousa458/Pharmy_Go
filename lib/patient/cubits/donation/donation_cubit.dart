import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmygo/patient/models/donation_model.dart';
import 'package:pharmygo/patient/repos/donation_repo/donation_repo.dart';

part 'donation_state.dart';

class DonationCubit extends Cubit<DonationState> {
  DonationCubit(this.donationRepo) : super(DonationInitial());
  final DonationRepo donationRepo;

  Future<void> addDonation({
    required DonationModel dontaion,
  }) async {
    emit(DonationLoading());
    var result = await donationRepo.addDonation(
        dontaion: dontaion);
    result.fold((failure) {
      emit(DonationFailure(errMessage: failure.toString()));
    }, (_) {
      emit(DonationSuccsess());
    });
  }
}
