// ignore_for_file: unused_local_variable
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:pharmygo/core/utils/constants.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/patient/cubits/get_nearst_pharmacies/get_nearst_pharmacies_cubit.dart';
import 'package:pharmygo/pharmacist/models/nearst_pharmacy_model.dart';
import 'package:pharmygo/public/cubits/trip_cubit/trip_cubit.dart';
import 'package:pharmygo/public/views/map/pharmacy_details_bottom_sheet.dart';

class FindNearestPharmacisOnMap extends StatefulWidget {
  const FindNearestPharmacisOnMap({super.key});
  static const String routeName = '/FindNearestPharmacisOnMap';

  @override
  State<FindNearestPharmacisOnMap> createState() =>
      _FindNearestPharmacisOnMapState();
}

class _FindNearestPharmacisOnMapState extends State<FindNearestPharmacisOnMap> {
  late Marker targetMarker;
  late List<Marker> nearestMarker;
  bool isButtonPressed = false;
  late List<NearestPharmacyModel> nearstPharmacies;
  late List<Marker> markerOfNearstPharmacies;
  int id = 0;
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
    initializeStream();
    WidgetsBinding.instance.addPostFrameCallback((Duration duration) {
      nearstPharmacies =
          BlocProvider.of<GetNearstPharmaciesCubit>(context).nearstPharmacies;
      markerOfNearstPharmacies = nearstPharmacies.map((NearestPharmacyModel phamacy) {
        return Marker(
          markerId: MarkerId('${++id}'),
          infoWindow: InfoWindow(
              title: phamacy.pharmacyName,
              snippet: 'Dr/ ${phamacy.pharmacist}'),
          position: LatLng(phamacy.latitude, phamacy.longitude),
          onTap: () {
            pharmacyDetailsBottomSheet(
                context: context,
                nearestPharmacy: phamacy);
          },
        );
      }).toList();
      setState(() {
        isButtonPressed = true;
      });
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

  void updateMarkers(Position position) {
    setState(() {
      targetMarker = Marker(
        infoWindow: const InfoWindow(
          title: 'My Loaction',
          snippet: 'My current Location',
        ),
        markerId: const MarkerId('1'),
        position: LatLng(
          position.latitude,
          position.longitude,
        ),
      );
      nearestMarker = findNearestMarkers(position.latitude, position.longitude);
      _showMarkers.add(targetMarker);
    });
    gmc?.animateCamera(
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)));
    if (isButtonPressed) {
      _showMarkers.removeWhere((Marker marker) => marker.markerId.value != '1');
      _showMarkers.addAll(nearestMarker);
      final bool isTripStarted = BlocProvider.of<TripCubit>(context).trip;
      if (isTripStarted) {
        _displayRoute(
          LatLng(position.latitude, position.longitude),
          LatLng(BlocProvider.of<TripCubit>(context).latitude,
              BlocProvider.of<TripCubit>(context).longitude),
        );
      }
    }
  }

  List<Marker> findNearestMarkers(double latitude, double longitude) {
    return markerOfNearstPharmacies
        .where((Marker marker) => marker.markerId.value != '1')
        .map((Marker marker) {
      final double distance = Geolocator.distanceBetween(
        latitude,
        longitude,
        marker.position.latitude,
        marker.position.longitude,
      );
      return marker.copyWith(
        iconParam:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );
    }).toList();
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
