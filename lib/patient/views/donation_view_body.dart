import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/patient/cubits/donation/donation_cubit.dart';
import 'package:pharmygo/patient/models/donation_model.dart';
import 'package:pharmygo/public/widgets/custom_button.dart';
import 'package:pharmygo/public/widgets/custom_text_field.dart';

class DonationViewBody extends StatelessWidget {
  const DonationViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    final donationFormKey = GlobalKey<FormState>();
    TextEditingController nameOfMedcineController = TextEditingController();
    TextEditingController quantityOfMedcineController = TextEditingController();
    TextEditingController addressController = TextEditingController();

    return SafeArea(
      child: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: 16.w), // Add padding to the edges
        child: Form(
          key: donationFormKey,
          child: Column(
            mainAxisSize: MainAxisSize
                .min, // Ensure the column takes the minimum vertical space
            children: [
              CustomTextField(
                controller: nameOfMedcineController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Medicine\'s Name';
                  }
                  return null;
                },
                hintText: "Medicine Name",
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomTextField(
                controller: quantityOfMedcineController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Quantity';
                  }
                  return null;
                },
                hintText: "Medicine Quantity",
                isNumber: true,
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomTextField(
                controller: addressController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Address';
                  }
                  return null;
                },
                hintText: "Address",
              ),
              // SizedBox(
              //   height: 16.h,
              // ),
              // CustomTextField(
              //   controller: expieryDateController,
              //     validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter the Medicine\'s Expiery Date';
              //     }
              //     return null;
              //   },
              //   hintText: "Expiery Date",
              //   // onChange: (data) {
              //   //   nameOfMedcine = data;
              //   // },
              // ),
              SizedBox(
                height: 50.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocConsumer<DonationCubit, DonationState>(
                    listener: (context, state) {
                      if (state is DonationSuccsess) {
                        showSnackBar(context, "Thanks For Your Donation 💕");
                        nameOfMedcineController.clear();
                        quantityOfMedcineController.clear();
                        addressController.clear();
                      }
                      if (state is DonationFailure) {
                        showSnackBar(context, state.errMessage);
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        width: 200.w,
                        onPressed: () {
                          if (donationFormKey.currentState!.validate()) {
                            BlocProvider.of<DonationCubit>(context).addDonation(
                              dontaion: DonationModel(
                                nameOfMedcine: nameOfMedcineController.text,
                                address: addressController.text,
                                quantityOfMedcine:
                                    quantityOfMedcineController.text,
                              ),
                            );
                          }
                        },
                        text: "Confirm",
                        isLoading: state is DonationLoading,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
