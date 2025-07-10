import 'package:equatable/equatable.dart';
import '../../model/city_model.dart';

abstract class SelectedCityState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SelectedCityInitial extends SelectedCityState {}

class SelectedCityLoading extends SelectedCityState {}

class SelectedCityLoaded extends SelectedCityState {
  final List<CityModel> cities;

  SelectedCityLoaded(this.cities);

  @override
  List<Object?> get props => [cities];
}

class SelectedCityError extends SelectedCityState {
  final String message;

  SelectedCityError(this.message);

  @override
  List<Object?> get props => [message];
}
