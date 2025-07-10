import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/service/location_service.dart';
import 'package:weather/src/model/weather_response.dart';
import 'package:weather/src/repository/weather_repository.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class MyWeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;
  final LocationService locationService;

  MyWeatherBloc({required this.locationService,  required this.repository}) : super(WeatherInitial()) {
    on<LoadWeatherForCurrentLocation>(_onLoadWeatherForCurrentLocation);
  }

  Future<void> _onLoadWeatherForCurrentLocation(
    LoadWeatherForCurrentLocation event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final position = await locationService.getCurrentPosition();
      final response = await repository.fetchWeather(
        lat: position.latitude,
        lon: position.longitude,
      );

      emit(WeatherLoaded([WeatherResponse.fromJson(response)]));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
