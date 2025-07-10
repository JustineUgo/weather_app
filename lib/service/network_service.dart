import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather/error/exceptions.dart';
import 'package:weather/service/log_service.dart';

enum NetworkMethod { post, get, delete, put, patch }

abstract class NetworkService {
  Future<dynamic> makeRequest(String path, {required NetworkMethod mode, Object? body, Options? options, Map<String, dynamic>? queryParameters});
}


class WeatherDioClient implements NetworkService {
  final Dio client;
  WeatherDioClient(this.client) {
    client.interceptors.add(DioNetworkInterceptor());
  }

  @override
  Future<dynamic> makeRequest(String path, {required NetworkMethod mode, Object? body, Options? options, Map<String, dynamic>? queryParameters}) async {
    late Response response;

    LogService.logDebug("$path | ${mode.name}");
    LogService.logDebug("Body: $body");
    if (queryParameters!=null) LogService.logDebug("Params: $queryParameters");

    switch (mode) {
      case NetworkMethod.post:
        response = await client.post(path, data: body, options: options, queryParameters: queryParameters);
        break;
      case NetworkMethod.get:
        response = await client.get(path, options: options, queryParameters: queryParameters);
        break;
      case NetworkMethod.put:
        response = await client.put(path, data: body, options: options, queryParameters: queryParameters);
        break;
      case NetworkMethod.patch:
        response = await client.patch(path, data: body, options: options, queryParameters: queryParameters);
        break;
      case NetworkMethod.delete:
        response = await client.delete(path, data: body, options: options, queryParameters: queryParameters);
        break;
      }
    LogService.logDebug("Response code: ${response.statusCode}");
    LogService.logDebug("Response message: ${response.statusMessage}");
    LogService.logDebug("Response: ${response.data}");
    return response.data;
  }
}

class DioNetworkInterceptor extends Interceptor {
  DioNetworkInterceptor();

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    
    LogService.logDebug("Url: ${options.uri.toString()}");
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    LogService.logDebug("Error: ${err.response?.data}");
    switch (err.type) {
      case DioExceptionType.cancel:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        throw ConnectionException(statusCode: err.response?.statusCode ?? 0, cause: err.type);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 401:
          case 400:
          case 403:
          case 404:
          case 409:
          case 429:
          case 406:
          case 422:
          dynamic error = err.response?.data["message"]?? err.response?.data["error"] ;
            throw UserException(error: error, statusCode: err.response?.statusCode ?? 0, stacktrace: err.stackTrace);
        }
        throw UnknownException(exception: err, stacktrace: err.stackTrace);

      default:
        if (err.error is HandshakeException || err.error is SocketException || err.error is TimeoutException) {
          throw ConnectionException(statusCode: err.response?.statusCode ?? 0, cause: err.type);
        } else {
          throw UnknownException(exception: err, stacktrace: err.stackTrace);
        }
    }
  }
}