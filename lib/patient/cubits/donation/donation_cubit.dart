// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmygo/patient/repos/donation_repo/donation_repo.dart';

part 'donation_state.dart';

class DonationCubit extends Cubit<DonationState> {
  DonationCubit(this.donationRepo) : super(DonationInitial());
  final DonationRepo donationRepo;

  addDonation({
    required String quantityOfMedcine,
    required String address,
    required String nameOfMedcine,
  }) async {
    var result = await donationRepo.addDonation(
        nameOfMedcine: nameOfMedcine,
        address: address,
        quantityOfMedcine: quantityOfMedcine);
    result.fold((failure) {
      emit(DonationFailure(errMessage: failure.toString()));
    }, (pharmacies) {
      // nearstPharmacies.clear();
      // nearstPharmacies.addAll(pharmacies);

      emit(DonationSuccsess());
    });
  }
}
