// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/core/utils/colors.dart';
import 'package:pharmygo/pharmacist/cubits/add_pharmacy_cubit/add_pharmacy_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/delivery_cubit/delivery_cubit.dart';
import 'package:pharmygo/public/widgets/custom_button.dart';
import 'package:pharmygo/public/widgets/custom_checkbox.dart';
import 'package:pharmygo/public/widgets/custom_text_field.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class AddPharmacyPage extends StatelessWidget {
  const AddPharmacyPage({super.key});

  static String routeName = "/AddPharmacyPage";
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    bool deliveryYes = false, deliveryNo = true, isLoading = false;
    String pharmacyName = "", pharmacyLocation = "";
    Position? position;
    late TextEditingController pharmacyLocationController =
        TextEditingController();
    return Scaffold(
      backgroundColor: ThemeColors.kSecondBackgroundColor(context),
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50),
        child: AppBar(
          title: Text(
            'Add Pharmacy',
            style: TextStyle(
              color: ThemeColors.kMainColor(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              // Handle back button press
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                color: ThemeColors.kMainColor(context)),
          ),
        ),
      ),
      body: Column(
        children: [
          const Spacer(flex: 2),
          FaIcon(
            FontAwesomeIcons.houseMedical,
            color: ThemeColors.kMainColor(context),
            size: 100,
          ),
          const Spacer(flex: 1),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CustomTextField(
              hintText: 'Pharmacy Name',
              hintColor: ThemeColors.kSecondColor(context),
              onChange: (value) {
                pharmacyName = value;
              },
              width: 400,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CustomTextField(
              hintText: 'Pharmacy Location',
              hintColor: ThemeColors.kSecondColor(context),
              endIcon: FontAwesomeIcons.locationCrosshairs,
              controller: pharmacyLocationController,
              onTapEndIcon: () async {
                try {
                  position = await _getCurrentLocation();
                  pharmacyLocation =
                      '${position!.longitude},${position!.latitude}';
                  showSnackBar(context, 'Your Current Loacation Added');
                } catch (e) {
                  showSnackBar(context, "Error getting current location");
                }
              },
              onChange: (value) {
                pharmacyLocation = value;
              },
              width: 400,
            ),
          ),
          BlocBuilder<DeliveryCubit, DeliveryState>(
            builder: (context, state) {
              if (state is DeliveryYes) {
                deliveryYes = true;
                deliveryNo = false;
              } else if (state is DeliveryNo) {
                deliveryYes = false;
                deliveryNo = true;
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Delivery",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: kMainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomCheckBox(
                    check: deliveryYes,
                    onChange: (value) {
                      BlocProvider.of<DeliveryCubit>(context).setDelivery(true);
                    },
                    text: "Yes",
                  ),
                  CustomCheckBox(
                    check: deliveryNo,
                    onChange: (value) {
                      BlocProvider.of<DeliveryCubit>(context)
                          .setDelivery(false);
                    },
                    text: "No",
                  ),
                ],
              );
            },
          ),
          const Spacer(flex: 5),
          BlocConsumer<AddPharmacyCubit, AddPharmacyState>(
            listener: (context, state) {
              if (state is AddPharmacyLoading) {
                isLoading = true;
              } else if (state is AddPharmacySuccess) {
                showSnackBar(context, "Successfully added pharmacy");
                isLoading = false;
              } else if (state is AddPharmacyFailure) {
                showSnackBar(context, state.errMessage);
                isLoading = false;
              }
            },
            builder: (context, state) {
              return CustomButton(
                text: 'ADD',
                width: 250,
                isLoading: isLoading,
                onPressed: () {
                  if (pharmacyName.isEmpty || pharmacyLocation.isEmpty) {
                    showSnackBar(context, "Please fill all fields");
                    return;
                  }

                  double longitude, latitude;

                  try {
                    List<String> parts = pharmacyLocation.split(',');
                    if (parts.length != 2) {
                      throw const FormatException('Invalid format');
                    }
                    longitude = double.parse(parts[0].trim());
                    latitude = double.parse(parts[1].trim());
                  } catch (e) {
                    showSnackBar(context,
                        "Invalid location format. Please use 'longitude,latitude' format.");
                    return;
                  }

                  BlocProvider.of<AddPharmacyCubit>(context).addPharmacy(
                    delivery: deliveryYes ? 1 : 0,
                    pharmacyName: pharmacyName,
                    longitude: longitude,
                    latitude: latitude,
                  );
                },
              );
            },
          ),
          const Spacer(flex: 10),
        ],
      ),
    );
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, do something
      throw Exception('Location services are disabled.');
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, do something
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Get the current location
    return await Geolocator.getCurrentPosition();
  }
}
