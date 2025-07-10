import 'package:equatable/equatable.dart';

abstract class CityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCitiesEvent extends CityEvent {}
