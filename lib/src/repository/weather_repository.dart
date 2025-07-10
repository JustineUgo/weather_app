
import 'package:weather/config/env_variables.dart';
import 'package:weather/service/network_service.dart';

abstract class WeatherRepository {
  Future<dynamic> fetchWeather({required double lat, required double lon});
}


class WeatherRepositoryImpl extends WeatherRepository{
  final NetworkService networkService;

  WeatherRepositoryImpl({required this.networkService});

  @override
  Future fetchWeather({required double lat, required double lon}) async {
    String key = EnvVariables.apiKey;
    final result = await networkService.makeRequest(
      "?lat=$lat&lon=$lon&appid=$key&units=metric",
      mode: NetworkMethod.get,
    );
    return result;
  }
}
