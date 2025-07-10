import 'package:equatable/equatable.dart';

class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadWeatherForCities extends WeatherEvent {
  final List<Coordinate> coordinates;

  LoadWeatherForCities(this.coordinates);

  @override
  List<Object?> get props => [coordinates];
}

class Coordinate extends Equatable {
  final double lat;
  final double lon;

  const Coordinate({required this.lat, required this.lon});

  @override
  List<Object?> get props => [lat, lon];
}
