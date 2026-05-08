part of 'pickup_image_cubit.dart';

@immutable
sealed class PickupImageState {}

final class PickupImageInitial extends PickupImageState {}

final class PickupImageLoading extends PickupImageState {}

final class PickupImageSuccess extends PickupImageState {
  final File image;
  PickupImageSuccess({required this.image});
}

final class PickupImageFailure extends PickupImageState {
  final String errMessage;

  PickupImageFailure({required this.errMessage});
}
