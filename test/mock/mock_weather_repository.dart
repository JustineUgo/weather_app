
// Mock WeatherRepository
import 'package:weather/src/repository/weather_repository.dart';

class MockWeatherRepository extends WeatherRepository {
  final dynamic response;
  final bool throwError;

  MockWeatherRepository({this.response, this.throwError = false});

  @override
  Future fetchWeather({required double lat, required double lon}) async {
    if (throwError) throw Exception('Weather fetch error');
    return response;
  }
}
