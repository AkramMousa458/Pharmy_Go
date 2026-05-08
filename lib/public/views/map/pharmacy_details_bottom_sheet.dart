import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/patient/views/patient_drugs_list_view.dart';
import 'package:pharmygo/pharmacist/models/nearst_pharmacy_model.dart';
import 'package:pharmygo/public/cubits/trip_cubit/trip_cubit.dart';
import 'package:pharmygo/public/widgets/custom_button.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

Future<dynamic> pharmacyDetailsBottomSheet({
  required BuildContext context,
  required NearestPharmacyModel nearestPharmacy,
  // required DrugModel drug,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: ThemeColors.kSecondBackgroundColor(context),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
        child: SizedBox(
          height: 500.h,
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(right: 20.sp, left: 20.sp, bottom: 8.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      nearestPharmacy.pharmacyName,
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: ThemeColors.kMainColor(context)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Dr/ ${nearestPharmacy.pharmacist}',
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: ThemeColors.kMainColor(context)),
                  ),
                ],
              ),
              SizedBox(
                height: 50.h,
              ),
              nearestPharmacy.delivery == 1
                  ? Column(
                      children: [
                        Text(
                          'this pharmacy have delivery',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color.fromARGB(234, 158, 158, 158),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        CustomButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, PatientDrugsListView.routeName);
                          },
                          text: "Choose medcines",
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        BlocConsumer<TripCubit, TripState>(
                          listener: (context, state) {
                            if (state is TripSuccess) {
                              Navigator.pop(context);
                            }
                          },
                          builder: (context, state) {
                            return CustomButton(
                              onPressed: () {
                                BlocProvider.of<TripCubit>(context).startTrip(
                                    latitude: nearestPharmacy.latitude,
                                    longitude: nearestPharmacy.longitude);
                              },
                              text: "Start Trip",
                            );
                          },
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        const Text(
                          "No Delivery Service",
                          style: TextStyle(
                            color: Color.fromARGB(234, 158, 158, 158),
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        CustomButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          text: "Start Trip",
                        ),
                      ],
                    ),
            ],
          ),
        ),
      );
    },
  );
}
