import 'package:dio/dio.dart';

abstract class TrackedException implements Exception {
  final String name;
  final dynamic error;
  final DioExceptionType? cause;
  final int? statusCode;
  final DioException? exception;
  final dynamic stacktrace;

  TrackedException({required this.name, this.error, this.cause, this.statusCode, this.exception, this.stacktrace});
}

class UnknownException extends TrackedException {
  UnknownException({required super.exception, required super.stacktrace}) : super(name: 'UnknownError');
}

class ConnectionException extends TrackedException {
  ConnectionException({required super.cause, required super.statusCode}) : super(name: 'HttpException');
}


class UserException extends TrackedException {
  UserException({required super.error, required super.statusCode, required super.stacktrace}) : super(name: 'UserException');
}