// import 'package:pharmygo/Features/home/data/models/book_model/book_model.dart';

// ignore_for_file: avoid_print

import 'package:pharmygo/core/errors/failures.dart';
import 'package:pharmygo/core/utils/api_services.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pharmygo/patient/models/donation_model.dart';
import 'package:pharmygo/patient/repos/donation_repo/donation_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DonationRepoImpl implements DonationRepo {
  final ApiService apiService;

  DonationRepoImpl(this.apiService);

  @override
  Future<Either<Failure, DonationModel>> addDonation(
      {required String nameOfMedcine,
      required String address,
      required String quantityOfMedcine}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("id") ?? 0;
    try {
      var data = await apiService.post(
          endPoint:
              'home/patient/dashboard/storeDonation?patient_id=$id&drug_name=$nameOfMedcine&quantity=$quantityOfMedcine&address=$address',
          data: {});
      print(data['message']);
      DonationModel donationModel = DonationModel.fromJson(data['message']);
      return right(donationModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
