import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmygo/patient/cubits/get_nearst_pharmacies_with_drug_cubit/get_nearst_pharmacies_with_drug_cubit.dart';
import 'package:pharmygo/public/models/drug_model.dart';
import 'package:pharmygo/patient/widgets/custom_back_button.dart';
import 'package:pharmygo/patient/widgets/custom_drugs_order_list_widget.dart';

class PatientDrugView extends StatefulWidget {
  const PatientDrugView({super.key});

  static const String routeName = '/PatientDrugView';

  @override
  State<PatientDrugView> createState() => _PatientDrugViewState();
}

class _PatientDrugViewState extends State<PatientDrugView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    checkPermissionsAndEnableGPS();
    super.initState();
  }

  Future<void> checkPermissionsAndEnableGPS() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      if (mounted) {
        showSnackBar(context, 'Please activate the GPS!');
      }
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
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
  }

  @override
  Widget build(BuildContext context) {
    DrugModel drug = ModalRoute.of(context)!.settings.arguments as DrugModel;
    BlocProvider.of<GetNearstPharmciesWithDrugCubit>(context)
        .getNearstPharmaciesWithDrug(drugId: drug.id);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Show Drug',
          style: TextStyle(
            color: ThemeColors.kMainColor(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: const CustomBackButton(),
      ),
      backgroundColor: ThemeColors.kBackgroundColor(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CustomDrugsOrderListWidget(productModel: drug),
          ),
        ],
      ),
    );
  }
}
