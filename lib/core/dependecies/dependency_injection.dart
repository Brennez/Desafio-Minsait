import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:git_app/app/data/datasources/remote_datasource/implementations/implementations_export.dart';
import 'package:git_app/app/data/datasources/remote_datasource/interfaces/interfaces_export.dart';
import 'package:git_app/core/http/implementation/http_client_impl.dart';
import 'package:git_app/core/http/interface/http_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/data/datasources/local_datasource/implementations/implementations.dart';
import '../../app/data/datasources/local_datasource/interfaces/interfaces_export.dart';
import '../../app/domain/repositories/implementations/implementations_export.dart';
import '../../app/domain/repositories/interfaces/interfaces_export.dart';
import '../../app/presentation/controllers/controllers_export.dart';

final GetIt injector = GetIt.instance;

void setupDependencies() {
  injector.registerLazySingleton<HttpClient>(() => HttpClientImpl(Dio()));

  // Datasources
  injector.registerLazySingleton<UserInfoDatasource>(
      () => UserInfoDatasourceImpl(httpClient: injector<HttpClient>()));

  injector.registerLazySingleton<CacheLocalDatasource>(
      () => CacheLocalDatasourceImpl());

  // repositories
  injector.registerLazySingleton<UserInfoRepository>(() =>
      UserInfoRepositoryImpl(
          userInfoDatasource: injector<UserInfoDatasource>()));

  injector.registerLazySingleton<CacheRepository>(() => CacheRepositoryImpl(
      cacheLocalDatasource: injector<CacheLocalDatasource>()));

  // controllers
  injector.registerLazySingleton<UserInfoController>(
      () => UserInfoController(injector<UserInfoRepository>()));

  injector.registerLazySingleton(
      () => CacheController(injector<CacheRepository>()));
}
