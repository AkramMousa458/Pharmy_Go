part of 'donation_cubit.dart';

@immutable
sealed class DonationState {}

final class DonationInitial extends DonationState {}

final class DonationSuccsess extends DonationState {}

final class DonationLoading extends DonationState {}

final class DonationFailure extends DonationState {
  final String errMessage;

  DonationFailure({required this.errMessage});
}
