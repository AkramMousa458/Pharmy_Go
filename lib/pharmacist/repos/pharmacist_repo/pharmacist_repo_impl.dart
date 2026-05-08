// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pharmygo/core/errors/failures.dart';
import 'package:pharmygo/core/utils/api_services.dart';
import 'package:pharmygo/pharmacist/models/pharmacist_model.dart';
import 'package:pharmygo/pharmacist/models/pharmacy_model.dart';
import 'package:pharmygo/pharmacist/models/pharmacy_orders_model.dart';
import 'package:pharmygo/pharmacist/repos/pharmacist_repo/pharmacist_repo.dart';
import 'package:pharmygo/public/models/drug_model.dart';
import 'package:pharmygo/public/models/shortage_drug_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PharmacistRepoImpl implements PharmacistRepo {
  final ApiService apiService;

  PharmacistRepoImpl(this.apiService);
  // @override
  // Future<Either<Failure, PharmacistModel>> getPharmacist() async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     int id = prefs.getInt("auth-id") ?? 0;
  //     var data = await apiService.get(
  //         endPoint: 'home/pharmacist/dashboard/getInformation/$id');
  //     PharmacistModel? pharmacist;
  //     pharmacist = PharmacistModel.fromJson(data['message']);
  //     return right(pharmacist);
  //   } catch (e) {
  //     if (e is DioException) {
  //       return left(ServerFailure.fromDioError(e));
  //     }
  //     return Left(
  //       ServerFailure(e.toString()),
  //     );
  //   }
  // }

  @override
  Future<Either<Failure, PharmacistModel>> getPharmacist() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int id = prefs.getInt("auth-id") ?? 0;
      var data = await apiService.get(
          endPoint: 'home/pharmacist/dashboard/getInformation/$id');
      PharmacistModel? pharmacist;
      pharmacist = PharmacistModel.fromJson(data['message']);
      return right(pharmacist);
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
  Future<Either<Failure, PharmacistModel>> updatePharmacist(
      {String? name,
      String? email,
      String? password,
      String? confPassword,
      String? phone,
      File? profileImage}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int id = prefs.getInt("auth-id") ?? 0;
      String endpoint = 'home/pharmacist/dashboard/storeInformation/$id';

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
        // if (profileImageMultipart != null) "image_url": profileImageMultipart,
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

      PharmacistModel result = PharmacistModel.fromJson(response['message']);
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
  Future<Either<Failure, List<PharmacyModel>>> getMyPharmacies() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int id = prefs.getInt("id") ?? 0;

      // Send the request
      var response = await apiService.get(
        // data: {},
        endPoint: 'home/pharmacist/dashboard/showPharmacies/pharmacist/$id',
      );

      // Print the response for debugging
      print('Pharmacies: $response');

      // Ensure the response is a map and contains the 'message' key
      if (response.containsKey('message')) {
        // Parse the list of pharmacies
        List<dynamic> messages = response['message'];
        List<PharmacyModel> result =
            messages.map((json) => PharmacyModel.fromJson(json)).toList();
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
  Future<Either<Failure, List<DrugModel>>> getMyMedcines(
      {required int pharmacyId}) async {
    try {
      // Send the request
      var response = await apiService.get(
        endPoint: 'home/pharmacist/dashboard/pharmacy/$pharmacyId/drugs',
      );

      // Print the response for debugging
      print('Response: $response');

      // Ensure the response is a map and contains the 'message' key
      if (response.containsKey('message')) {
        // Parse the list of pharmacies
        List<dynamic> messages = response['message'];
        List<DrugModel> result =
            messages.map((json) => DrugModel.fromJson(json)).toList();
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
  Future<Either<Failure, String>> addMedicine(
      {required int pharmacyId,
      required int drugId,
      required int quantity}) async {
    try {
      String endpoint = 'home/pharmacist/dashboard/storeDrugs';

      // Prepare the form data
      var body = [
        {
          "pharmacyId": pharmacyId.toString(),
          "drugId": drugId.toString(),
          "quantity": quantity.toString(),
        }
      ];

      // Send the request
      var response = await apiService.post(
        data: body,
        endPoint: endpoint,
      );

      // Print the response for debugging
      print('Response: $response');

      return right(response['message']);
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
  Future<Either<Failure, String>> deleteMedicine(
      {required int pharmacyId, required int drugId}) async {
    try {
      // Send the request
      var response = await apiService.delete(
          endPoint:
              'home/pharmacist/dashboard/pharmacy/$pharmacyId/drugs/$drugId');

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
  Future<Either<Failure, String>> addPharmacy(
      {required int pharmacyId,
      required int delivery,
      required String pharmacyName,
      required double longitude,
      required double latitude}) async {
    try {
      String endpoint =
          'home/pharmacist/dashboard/pharmacist/$pharmacyId/storePharmacy?pharmacy_name=$pharmacyName&longitude=$longitude&latitude=$latitude&delivery=$delivery';

      // Prepare the form data

      // Send the request
      var response = await apiService.post(
        data: [],
        endPoint: endpoint,
      );

      // Print the response for debugging
      print('Response: $response');

      return right(response['message']);
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
  Future<Either<Failure, List<ShortageDrugModel>>> getShortageDrugs(
      {required int pharmacyId}) async {
    try {
      // Send the request
      var response = await apiService.get(
        endPoint:
            'home/pharmacist/dashboard/pharmacy/$pharmacyId/get-inability-drugs',
      );

      // Print the response for debugging
      print('Response: $response');

      // Ensure the response is a map and contains the 'message' key
      if (response.containsKey('message')) {
        // Parse the list of pharmacies
        List<dynamic> messages = response['message'];
        List<ShortageDrugModel> result =
            messages.map((json) => ShortageDrugModel.fromJson(json)).toList();
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
  Future<Either<Failure, List<PharmacyOrderModel>>> getPharmacyOrders(
      {required int pharmacyId}) async {
    try {
      print('===========$pharmacyId=================');
      // Send the request
      var response = await apiService.get(
        endPoint: 'home/pharmacist/dashboard/pharmacy/$pharmacyId/getClients',
      );

      // Print the response for debugging
      print('Response: $response');

      // Ensure the response is a map and contains the 'message' key
      if (response.containsKey('message')) {
        // Parse the list of pharmacies
        List<dynamic> messages = response['message'];
        List<PharmacyOrderModel> result =
            messages.map((json) => PharmacyOrderModel.fromJson(json)).toList();
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
  Future<Either<Failure, String>> deleteOrder(
    {required int patientId, required int orderId}) async {
    try {
      // Send the request
      var response = await apiService.delete( 
          endPoint:
              'home/patient/dashboard/delete/$patientId/order/$orderId');

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

}
