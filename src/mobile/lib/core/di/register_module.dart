import 'package:dio/dio.dart';
import 'package:media_catalog_app/core/network/api_base_url.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio {
    const configuredBaseUrl = String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'http://localhost:59610/api/v1/',
    );

    return Dio(
      BaseOptions(
        baseUrl: normalizeApiBaseUrl(configuredBaseUrl),
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: const {'Accept': 'application/json'},
      ),
    );
  }

  @preResolve
  Future<SharedPreferences> get preferences => SharedPreferences.getInstance();
}
