// import 'package:pharmygo/Features/home/data/models/book_model/book_model.dart';

// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:pharmygo/core/errors/failures.dart';
import 'package:pharmygo/core/utils/api_services.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pharmygo/patient/repos/patients_repo/patients_repo.dart';
import 'package:pharmygo/pharmacist/models/nearst_pharmacy_model.dart';
import 'package:pharmygo/public/models/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/patient_model.dart';

class PatientsRepoImpl implements PatientsRepo {
  final ApiService apiService;

  PatientsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, PatientModel>> getPatient() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int id = prefs.getInt("auth-id") ?? 0;
      var data = await apiService.get(
          endPoint: 'home/patient/dashboard/getInformation/$id');

      PatientModel? patient;
      patient = PatientModel.fromJson(data['message']);
      return right(patient);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return Left(
        ServerFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, PatientModel>> updatePatient({
    String? name,
    String? email,
    String? password,
    String? confPassword,
    String? phone,
    File? profileImage,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int id = prefs.getInt("auth-id") ?? 0;
      String endpoint = 'home/patient/dashboard/storeInformation/$id';

      // Prepare the MultipartFile for the profile image
      MultipartFile? profileImageMultipart;
      if (profileImage != null) {
        profileImageMultipart = await MultipartFile.fromFile(
          profileImage.path,
          filename: profileImage.path.split('/').last,
        );
      }

      // Prepare the form data
      FormData formData = FormData.fromMap({
        "id": id,
        "name": name,
        "phone": phone,
        if (profileImageMultipart != null) "image_url": profileImageMultipart,
      });

      // Print the form data for debugging
      print('FormData: ${formData.fields}');
      print('Profile Image: ${profileImageMultipart?.filename}');

      // Send the request
      var response = await apiService.postUpdate(
        data: formData,
        endPoint: endpoint,
      );

      // Print the response for debugging
      print('Response: $response');

      PatientModel result = PatientModel.fromJson(response['message']);
      return right(result);
    } catch (e) {
      // Print the error for debugging
      print('Error: $e');

      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NearestPharmacyModel>>>
      getNearstPharmaciesWithDrug({required int drugId}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int id = prefs.getInt("auth-id") ?? 0;

      print(
          '============================userID: $id, DrugID: $drugId============================');
      // Send the request
      var response = await apiService.get(
        endPoint:
            'home/patient/dashboard/showNearestPharmacies/user/$id/drug/$drugId',
      );

      // Print the response for debugging
      print('Response: $response');

      // Ensure the response is a map and contains the 'message' key
      if (response.containsKey('message')) {
        // Parse the list of pharmacies
        List<dynamic> messages = response['message'];
        List<NearestPharmacyModel> result = messages
            .map((json) => NearestPharmacyModel.fromJson(json))
            .toList();
        return right(result);
      } else {
        return left(ServerFailure('Unexpected response format'));
      }
    } catch (e) {
      // Print the error for debugging
      print('Error: $e');

      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NearestPharmacyModel>>>
      getNearstPharmacies() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int id = prefs.getInt("auth-id") ?? 0;

      print(
          '============================userID: $id, DrugID:============================');
      // Send the request
      var response = await apiService.get(
        endPoint: 'home/patient/dashboard/showNearestPharmacies/user/$id',
      );

      // Print the response for debugging
      print('Response: $response');

      // Ensure the response is a map and contains the 'message' key
      if (response.containsKey('message')) {
        // Parse the list of pharmacies
        List<dynamic> messages = response['message'];
        List<NearestPharmacyModel> result = messages
            .map((json) => NearestPharmacyModel.fromJson(json))
            .toList();
        return right(result);
      } else {
        return left(ServerFailure('Unexpected response format'));
      }
    } catch (e) {
      // Print the error for debugging
      print('Error: $e');

      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> addOrderToCart(
      {required int pharmacyId,
      required int drugId,
      required int quantity}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int id = prefs.getInt("auth-id") ?? 0;

      print(
          '============================userID: $id============================');
      final body = jsonEncode({
        'items': [
          {
            'drug_id': drugId,
            'quantity': quantity,
          }
        ],
      });
      // Send the request
      var response = await apiService.post(
          endPoint:
              'home/patient/dashboard/storeCart/patient/$id/pharmacy/$pharmacyId',
          data: body);

      // Print the response for debugging
      print('Response: $response');

      // Ensure the response is a map and contains the 'message' key
      if (response.containsKey('message')) {
        // Parse the list of pharmacies
        String result = response['message'];

        return right(result);
      } else {
        return left(ServerFailure('Unexpected response format'));
      }
    } catch (e) {
      // Print the error for debugging
      print('Error: $e');

      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getCart() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int id = prefs.getInt("auth-id") ?? 0;

      log('============================userID: $id ===========================');
      // Send the request
      var response = await apiService.get(
        endPoint: 'home/patient/dashboard/$id/getAllCarts',
      );

      // Print the response for debugging
      print('Response: $response');

      List<dynamic> messages = response['message'];
      List<OrderModel> result =
          messages.map((json) => OrderModel.fromJson(json)).toList();
      return right(result);
      // Ensure the response is a map and contains the 'message' key
      // if (response.containsKey('message')) {
      //   // Parse the list of pharmacies

      // } else {
      //   return left(ServerFailure('Unexpected response format'));
      // }
    } catch (e) {
      // Print the error for debugging
      print('Error: $e');

      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> addOrder(
      {required int pharmacyId,
      required int drugId,
      required int quantity}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int id = prefs.getInt("id") ?? 0;

      print(
          '============================userID: $id, DrugID:============================');
      final body = jsonEncode({
        'items': [
          {
            'drug_id': drugId,
            'quantity': quantity,
          }
        ],
      });
      // Send the request
      var response = await apiService.post(
          endPoint:
              'home/patient/dashboard/storeOrder/patient/$id/pharmacy/$pharmacyId',
          data: body);

      // Print the response for debugging
      print('Response: $response');

      // Ensure the response is a map and contains the 'message' key
      if (response.containsKey('message')) {
        // Parse the list of pharmacies
        String result = response['message'];

        return right(result);
      } else {
        return left(ServerFailure('Unexpected response format'));
      }
    } catch (e) {
      // Print the error for debugging
      print('Error: $e');

      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getOrders() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int id = prefs.getInt("id") ?? 0;

      print(
          '============================userID: $id ===========================');
      // Send the request
      var response = await apiService.get(
        endPoint: 'home/patient/dashboard/$id/getAllOrders',
      );

      // Print the response for debugging
      print('Response: $response');

      // Ensure the response is a map and contains the 'message' key
      if (response.containsKey('message')) {
        // Parse the list of pharmacies
        List<dynamic> messages = response['message'];
        List<OrderModel> result =
            messages.map((json) => OrderModel.fromJson(json)).toList();
        return right(result);
      } else {
        return left(ServerFailure('Unexpected response format'));
      }
    } catch (e) {
      // Print the error for debugging
      print('Error: $e');

      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteOrderFromCart(
      {required int orderId}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int id = prefs.getInt("auth-id") ?? 0;

      print(
          '============================userID: $id ============================');
      // Send the request
      var response = await apiService.delete(
          endPoint: 'home/patient/dashboard/delete/$id/cart/$orderId');

      // Print the response for debugging
      print('Response: $response');

      // Ensure the response is a map and contains the 'message' key
      if (response.containsKey('message')) {
        // Parse the list of pharmacies
        String result = response['message'];

        return right(result);
      } else {
        return left(ServerFailure('Unexpected response format'));
      }
    } catch (e) {
      // Print the error for debugging
      print('Error: $e');

      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updatePatientLocation({
    required String longitude,
    required String latitude,
  }) async {
    try {
      Position position = await _getCurrentLocation();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(position.longitude);
      int id = prefs.getInt("auth-id") ?? 0;
      String endpoint =
          'home/patient/dashboard/storeInformation/$id?longitude=${position.latitude}&latitude=${position.longitude}';

      // Send the request
      var response = await apiService.post(
        data: {},
        endPoint: endpoint,
      );

      // Print the response for debugging
      print('Response: $response');

      String result = response['message'];
      return right(result);
    } catch (e) {
      // Print the error for debugging
      print('Error: $e');

      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
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
  // @override
  // Future<Either<Failure, String>> addOrderToCard({
  //   required String patientId,
  //   required String pharmacyId,
  //   required int drugId,
  //   required int quantity,
  // }) async {
  //   try {
  //     // List<int> ordredDrugsIdList =
  //     //     orderedDrugs.map((drug) => drug.id).toList();
  //     Map<String, dynamic> body = {
  //       "items": [
  //         {
  //           "drug_id": drugId,
  //           "quantity": quantity,
  //         },
  //       ]
  //     };
  //     var data = await apiService.post(
  //         endPoint:
  //             'home/patient/dashboard/storeOrder/patient/$patientId/pharmacy/$pharmacyId',
  //         data: body);
  //     String result = data['message'];
  //     return right(result);
  //   } catch (e) {
  //     if (e is DioException) {
  //       return left(ServerFailure.fromDioError(e));
  //     }
  //     return Left(
  //       ServerFailure(e.toString()),
  //     );
  //   }
  // }
}
