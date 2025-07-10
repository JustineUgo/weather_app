import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/src/model/weather_response.dart';
import 'package:weather/src/repository/weather_repository.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;

  WeatherBloc({required this.repository}) : super(WeatherInitial()) {
    on<LoadWeatherForCities>(_onLoadWeather);
  }

  Future _onLoadWeather(event, emit) async {
    emit(WeatherLoading());
    try {
      final List<WeatherResponse> weatherData = [];
      for (final coord in event.coordinates) {
        final weather = await repository.fetchWeather(lat:  coord.lat, lon:  coord.lon);
        weatherData.add(WeatherResponse.fromJson( weather));
      }
      emit(WeatherLoaded(weatherData));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
