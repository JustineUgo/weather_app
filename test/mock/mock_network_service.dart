import 'package:weather/service/network_service.dart';

class MockNetworkService implements NetworkService {
  dynamic Function(String path, {required NetworkMethod mode, Object? body, dynamic options, Map<String, dynamic>? queryParameters})? onMakeRequest;

  @override
  Future<dynamic> makeRequest(String path,
      {required NetworkMethod mode, Object? body, options, Map<String, dynamic>? queryParameters}) async {
    if (onMakeRequest != null) {
      return await onMakeRequest!(path, mode: mode, body: body, options: options, queryParameters: queryParameters);
    }
    throw UnimplementedError('MockNetworkService.makeRequest not implemented');
  }
}
