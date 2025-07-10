import 'package:equatable/equatable.dart';
import '../../model/city_model.dart';

abstract class SelectedCityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSelectedCities extends SelectedCityEvent {}

class AddCityToSelection extends SelectedCityEvent {
  final CityModel city;

  AddCityToSelection(this.city);

  @override
  List<Object?> get props => [city];
}

class RemoveCityFromSelection extends SelectedCityEvent {
  final CityModel city;

  RemoveCityFromSelection(this.city);

  @override
  List<Object?> get props => [city];
}
