// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';

// abstract class BackgroundService {
//  static final _service = FlutterBackgroundService();

//  static Future<void> initializeService() async {
//  await _service.configure(
//  androidConfiguration: AndroidConfiguration(
//  onStart: onStart,
//  autoStart: true,
//  isForegroundMode: true,
//  ),
//  iosConfiguration: IosConfiguration(
//  onForeground: onStart,
//  onBackground: onIosBackground,
//  ),
//  );
//  }

//  static onStart(ServiceInstance service) async {
//  DartPluginRegistrant.ensureInitialized();
//  }

//  static Future<bool> onIosBackground(ServiceInstance service) {
//  WidgetsFlutterBinding.ensureInitialized();
//  DartPluginRegistrant.ensureInitialized();

//  return Future.value(true);
//  }


// }
