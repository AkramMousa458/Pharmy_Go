// import 'package:pharmygo/Features/home/data/models/book_model/book_model.dart';

import 'package:pharmygo/core/errors/failures.dart';
import 'package:pharmygo/core/utils/api_services.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pharmygo/public/models/drug_model.dart';

import 'drugs_repo.dart';

class DrugsRepoImpl implements DrugsRepo {
  final ApiService apiService;

  DrugsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<DrugModel>>> fetchDrugs() async {
    try {
      var data =
          await apiService.get(endPoint: 'home/patient/dashboard/getAllDrugs');
      List<DrugModel> drugs = [];
      for (var item in data['message']) {
        try {
          drugs.add(DrugModel.fromJson(item));
        } catch (e) {
          if (kDebugMode) {
            // print(item);
          }
        }
      }
      return right(drugs);
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
  Future<Either<Failure, String>> addOrderToCard({
    required String patientId,
    required String pharmacyId,
    required int drugId,
    required int quantity,
  }) async {
    try {
      // List<int> ordredDrugsIdList =
      //     orderedDrugs.map((drug) => drug.id).toList();
      Map<String, dynamic> body = {
        "items": [
          {
            "drug_id": drugId,
            "quantity": quantity,
          },
        ]
      };
      var data = await apiService.post(
          endPoint:
              'home/patient/dashboard/storeOrder/patient/$patientId/pharmacy/$pharmacyId',
          data: body);
      String result = data['message'];
      return right(result);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return Left(
        ServerFailure(e.toString()),
      );
    }
  }
}
