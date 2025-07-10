import 'package:equatable/equatable.dart';
import 'package:weather/src/model/city_model.dart';


abstract class CityState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CityInitial extends CityState {}

class CityLoading extends CityState {}

class CityLoaded extends CityState {
  final List<CityModel> cities;

  CityLoaded(this.cities);

  @override
  List<Object?> get props => [cities];
}

class CityError extends CityState {
  final String message;

  CityError(this.message);

  @override
  List<Object?> get props => [message];
}
