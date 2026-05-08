import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'pickup_image_state.dart';

class PickupImageCubit extends Cubit<PickupImageState> {
  PickupImageCubit() : super(PickupImageInitial());

  File? selectedImage;

  Future<void> pickupImage({
    required BuildContext context,
    required bool fromCamera,
  }) async {
    emit(PickupImageLoading());
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      );
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        emit(PickupImageSuccess(image: selectedImage!));
      } else {
        selectedImage = null;
        emit(PickupImageFailure(
            errMessage:
                fromCamera ? 'No image captured' : 'No image selected'));
      }
    } catch (e) {
      selectedImage = null;
      emit(PickupImageFailure(
          errMessage: 'Error picking image: ${e.toString()}'));
    }
  }
}
