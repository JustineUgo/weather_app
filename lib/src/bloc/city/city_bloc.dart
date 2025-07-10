import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/src/repository/city_repository.dart';
import 'city_event.dart';
import 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final CityRepository repository;

  CityBloc({required this.repository}) : super(CityInitial()) {
    on<LoadCitiesEvent>(_onLoadCities);
  }

  Future<void> _onLoadCities(event, emit) async {
    emit(CityLoading());
    try {
      final cities = await repository.loadCitiesFromAssets();
      emit(CityLoaded(cities));
    } catch (e) {
      emit(CityError("Failed to load cities: $e"));
    }
  }
}
