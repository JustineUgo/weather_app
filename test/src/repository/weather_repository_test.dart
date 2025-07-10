import 'package:flutter_test/flutter_test.dart';
import 'package:weather/src/repository/weather_repository.dart';
import 'package:weather/service/network_service.dart';
import 'package:weather/config/env_variables.dart';
import '../../mock/mock_network_service.dart';


void main() {
  late WeatherRepositoryImpl repository;
  late MockNetworkService mockNetworkService;

  setUp(() {
    mockNetworkService = MockNetworkService();
    repository = WeatherRepositoryImpl(networkService: mockNetworkService);
    EnvVariables.apiKey = 'test_api_key';
  });

  test('fetchWeather calls networkService with correct path and returns result', () async {
    final lat = 12.34;
    final lon = 56.78;

    final fakeResponse = {'temp': 25};

    mockNetworkService.onMakeRequest = (path, {required mode, body, options, queryParameters}) async {
      expect(mode, NetworkMethod.get);
      expect(path, '?lat=$lat&lon=$lon&appid=test_api_key&units=metric');
      return fakeResponse;
    };

    final result = await repository.fetchWeather(lat: lat, lon: lon);

    expect(result, fakeResponse);
  });

  test('fetchWeather throws if networkService throws', () async {
    mockNetworkService.onMakeRequest = (path, {required mode, body, options, queryParameters}) async {
      throw Exception('Network failure');
    };

    expect(() => repository.fetchWeather(lat: 0, lon: 0), throwsException);
  });
}
