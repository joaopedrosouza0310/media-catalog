import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiClient {
  ApiClient(this.dio);

  final Dio dio;
}
