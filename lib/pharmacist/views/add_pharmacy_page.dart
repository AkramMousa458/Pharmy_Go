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

class AddPharmacyPage extends StatefulWidget {
  const AddPharmacyPage({super.key});

  static String routeName = "/AddPharmacyPage";
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<AddPharmacyPage> createState() => _AddPharmacyPageState();
}

class _AddPharmacyPageState extends State<AddPharmacyPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  bool _deliveryYes = false;
  bool _deliveryNo = true;
  bool _isLoading = false;
  String _pharmacyName = "";
  String _pharmacyLocation = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DeliveryCubit>(context).setDelivery(false);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.kSecondBackgroundColor(context),
      key: AddPharmacyPage.scaffoldKey,
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
              Navigator.pop(context);
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
              controller: _nameController,
              onChange: (value) {
                _pharmacyName = value;
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
              controller: _locationController,
              onTapEndIcon: () async {
                bool isLocationServiceEnabled =
                    await Geolocator.isLocationServiceEnabled();
                if (!isLocationServiceEnabled) {
                  if (mounted) {
                    showSnackBar(context, 'Please activate the GPS!');
                  }
                  await Geolocator.openLocationSettings();
                  return;
                }

                LocationPermission permission =
                    await Geolocator.checkPermission();
                if (permission == LocationPermission.denied) {
                  permission = await Geolocator.requestPermission();
                  if (permission == LocationPermission.denied) {
                    if (mounted) {
                      showSnackBar(context, 'Please activate the GPS!');
                    }
                    return;
                  }
                }

                if (permission == LocationPermission.deniedForever) {
                  if (mounted) {
                    showSnackBar(context, 'Please activate the GPS!');
                  }
                  await Geolocator.openAppSettings();
                  return;
                }

                try {
                  Position currentPosition =
                      await Geolocator.getCurrentPosition();
                  if (mounted) {
                    setState(() {
                      _pharmacyLocation =
                          '${currentPosition.longitude},${currentPosition.latitude}';
                      _locationController.text = _pharmacyLocation;
                    });
                    showSnackBar(context, 'Your Current Location Added');
                  }
                } catch (e) {
                  if (mounted) {
                    showSnackBar(context, "Error getting current location");
                  }
                }
              },
              onChange: (value) {
                _pharmacyLocation = value;
              },
              width: 400,
            ),
          ),
          BlocBuilder<DeliveryCubit, DeliveryState>(
            builder: (context, state) {
              if (state is DeliveryYes) {
                _deliveryYes = true;
                _deliveryNo = false;
              } else if (state is DeliveryNo) {
                _deliveryYes = false;
                _deliveryNo = true;
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
                    check: _deliveryYes,
                    onChange: (value) {
                      BlocProvider.of<DeliveryCubit>(context).setDelivery(true);
                    },
                    text: "Yes",
                  ),
                  CustomCheckBox(
                    check: _deliveryNo,
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
                setState(() {
                  _isLoading = true;
                });
              } else if (state is AddPharmacySuccess) {
                showSnackBar(context, "Successfully added pharmacy");
                setState(() {
                  _isLoading = false;
                });
                Navigator.pop(context);
              } else if (state is AddPharmacyFailure) {
                showSnackBar(context, state.errMessage);
                setState(() {
                  _isLoading = false;
                });
              }
            },
            builder: (context, state) {
              return CustomButton(
                text: 'ADD',
                width: 250,
                isLoading: _isLoading,
                onPressed: () {
                  if (_pharmacyName.isEmpty || _pharmacyLocation.isEmpty) {
                    showSnackBar(context, "Please fill all fields");
                    return;
                  }

                  double longitude, latitude;

                  try {
                    List<String> parts = _pharmacyLocation.split(',');
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
                    delivery: _deliveryYes ? 1 : 0,
                    pharmacyName: _pharmacyName,
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
}
