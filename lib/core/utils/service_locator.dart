import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pharmygo/core/utils/api_services.dart';
import 'package:pharmygo/public/repos/drugs_repo/drugs_repo_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(
    ApiService(
      Dio(),
    ),
  );
  getIt.registerSingleton<DrugsRepoImpl>(
    DrugsRepoImpl(
      getIt.get<ApiService>(),
    ),
  );
}
