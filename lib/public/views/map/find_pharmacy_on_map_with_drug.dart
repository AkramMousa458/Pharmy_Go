// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/core/utils/constants.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/pharmacist/models/nearst_pharmacy_model.dart';
import 'package:pharmygo/public/cubits/quantity_counter_cubit/quantity_counter_cubit.dart';
import 'package:pharmygo/public/models/drug_model.dart';
import 'package:pharmygo/public/views/map/option_buy_bottom_sheet.dart';

class FindPharmacyOnMapWithDrug extends StatefulWidget {
  const FindPharmacyOnMapWithDrug({super.key});
  static const String routeName = '/CustomGoogleMap';

  @override
  State<FindPharmacyOnMapWithDrug> createState() =>
      _FindPharmacyOnMapWithDrugState();
}

class _FindPharmacyOnMapWithDrugState extends State<FindPharmacyOnMapWithDrug> {
  late Marker targetMarker;
  late Marker nearestMarker;
  bool isButtonPressed = false;
  late DrugModel drug;
  late NearestPharmacyModel nearestPharmacyModel;
  final CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(30.560600, 31.010910),
    zoom: 12,
  );
  GoogleMapController? gmc;
  StreamSubscription<Position>? positionStream;
  final Set<Marker> _showMarkers = <Marker>{};
  Set<Polyline> _polylines = <Polyline>{};
  String _distanceText = '';
  String _durationText = '';

  @override
  void initState() {
    super.initState();
    targetMarker = const Marker(
      markerId: MarkerId('1'),
      position: LatLng(30.560600, 31.010910),
    );
    WidgetsBinding.instance.addPostFrameCallback((Duration duration) {
      final Map<dynamic, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
      nearestPharmacyModel = args['nearesrPharmacy'] as NearestPharmacyModel;
      drug = args['drugModel'] as DrugModel;
      initializeStream();
      setState(() {
        isButtonPressed = true;
      });
      BlocProvider.of<QuantityCounterCubit>(context).quantity = 1;
      BlocProvider.of<QuantityCounterCubit>(context).decreaseQuantity();
      optionBuyBottomSheet(
          context: context, drug: drug, nearestPharmacy: nearestPharmacyModel);
    });
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }

  void initializeStream() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSnackBar(context, 'Please Enable Loaction Service');
      log('Service Location Not Enable');
      return;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log('Location permissions are denied');
        return;
      }
    }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      positionStream =
          Geolocator.getPositionStream().listen((Position? position) {
        if (position != null) {
          updateMarkers(position);
        }
      });
    }
  }

  void updateMarkers(
    Position position,
  ) async {
    setState(() {
      targetMarker = Marker(
        markerId: const MarkerId('1'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: const InfoWindow(
            title: 'My Loaction', snippet: 'My current Location'),
      );
      nearestMarker = Marker(
        markerId: MarkerId(nearestPharmacyModel.distance.toString()),
        onTap: () {
          optionBuyBottomSheet(
              context: context,
              drug: drug,
              nearestPharmacy: nearestPharmacyModel);
        },
        infoWindow: InfoWindow(
          title: nearestPharmacyModel.pharmacyName,
          onTap: () {},
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        position: LatLng(
            nearestPharmacyModel.latitude, nearestPharmacyModel.longitude),
      );
      _showMarkers.add(targetMarker);
    });
    gmc?.animateCamera(
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)));
    if (isButtonPressed) {
      _showMarkers.removeWhere((Marker marker) => marker.markerId.value != '1');
      _showMarkers.add(nearestMarker);
      _displayRoute(
        LatLng(position.latitude, position.longitude),
        nearestMarker.position,
      );
    }
  }

  Future<void> _displayRoute(LatLng start, LatLng end) async {
    try {
      final String url =
          'http://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?overview=full&geometries=geojson';
      final http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        final List<dynamic> geometry = jsonResponse['routes'][0]['geometry']['coordinates'] as List<dynamic>;
        final double distance = (jsonResponse['routes'][0]['distance'] as num).toDouble();
        final double duration = (jsonResponse['routes'][0]['duration'] as num).toDouble();
        final List<LatLng> polylinePoints = <LatLng>[];
        for (final dynamic point in geometry) {
          polylinePoints.add(LatLng((point as List<dynamic>)[1] as double, point[0] as double));
        }
        setState(() {
          _polylines = <Polyline>{
            Polyline(
              polylineId: const PolylineId('route'),
              points: polylinePoints,
              color: Colors.blue,
              width: 5,
            ),
          };
          _distanceText = 'Distance: ${(distance / 1000).toStringAsFixed(2)} km';
          _durationText = 'Duration: ${(duration / 60).toStringAsFixed(2)} mins';
        });
      } else {
        throw Exception('Failed to load route');
      }
    } catch (e) {
      log('Error fetching route: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: appBarSize,
        child: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
          title: const Padding(
            padding: EdgeInsets.only(left: 40),
            child: Text(
              'Nearest Pharmacy',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: cameraPosition,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController mapcontroller) {
              gmc = mapcontroller;
            },
            markers: _showMarkers,
            polylines: _polylines,
          ),
          Positioned(
            bottom: 0,
            left: 100,
            child: Container(
              height: 60.h,
              width: Dimensions.screenWidth(context) / 2,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _distanceText,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _durationText,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
