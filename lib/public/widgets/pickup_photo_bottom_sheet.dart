import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/public/cubits/pickup_image_cubit/pickup_image_cubit.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
Future<dynamic> pickupPhotoBottomSheet(
    {required BuildContext context, required String title}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: ThemeColors.kSecondBackgroundColor(context),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SizedBox(
          height: 150.h,
          child: Column(
            children: [ 
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    // const Icon(deleteIcon),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              BlocConsumer<PickupImageCubit, PickupImageState>(
                listener: (context, state) {
                  if (state is PickupImageFailure) {
                    Navigator.pop(context);
                    showSnackBar(context, state.errMessage);
                  } else if (state is PickupImageSuccess) {
                    Navigator.pop(context);
                    showSnackBar(context, 'ID Card Uploaded Successfully');
                  }
                },
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                context.read<PickupImageCubit>().pickupImage(
                                    context: context, fromCamera: true);
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                size: 70,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text("Camera"),
                          ],
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                context.read<PickupImageCubit>().pickupImage(
                                    context: context, fromCamera: false);
                              },
                              icon: const Icon(
                                size: 70,
                                Icons.photo,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text("Gallery"),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      );
    },
  );
}
