import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/service/storage_service.dart';
import 'package:weather/src/bloc/city/selected_city_event';
import '../../model/city_model.dart';
import '../../repository/city_repository.dart';
import 'selected_city_state.dart';

class SelectedCityBloc extends Bloc<SelectedCityEvent, SelectedCityState> {
  final StorageService storageService;
  final CityRepository cityRepository;

  List<CityModel> _permanentCities = [];

  SelectedCityBloc({required this.storageService, required this.cityRepository})
      : super(SelectedCityInitial()) {
    on<LoadSelectedCities>(_onLoadCities);
    on<AddCityToSelection>(_onAddCity);
    on<RemoveCityFromSelection>(_onRemoveCity);
  }

  Future<void> _onLoadCities(
      LoadSelectedCities event, Emitter<SelectedCityState> emit) async {
    emit(SelectedCityLoading());
    try {
      final hasStored = await storageService.hasStoredCities();

      if (!hasStored) {
        final assetCities = await cityRepository.loadCitiesFromAssets();
        _permanentCities = assetCities.take(3).toList();
        await storageService.saveSelectedCities(_permanentCities);
        emit(SelectedCityLoaded(_permanentCities));
      } else {
        final stored = await storageService.loadSelectedCities();
        final assetCities = await cityRepository.loadCitiesFromAssets();
        _permanentCities = assetCities.take(3).toList();
        emit(SelectedCityLoaded(stored));
      }
    } catch (e) {
      emit(SelectedCityError("Failed to load selected cities: $e"));
    }
  }

  Future<void> _onAddCity(
      AddCityToSelection event, Emitter<SelectedCityState> emit) async {
    try {
      await storageService.addCity(event.city);
      final updated = await storageService.loadSelectedCities();
      emit(SelectedCityLoaded(updated));
    } catch (e) {
      emit(SelectedCityError("Failed to add city: $e"));
    }
  }

  Future<void> _onRemoveCity(
      RemoveCityFromSelection event, Emitter<SelectedCityState> emit) async {
    try {
      await storageService.removeCity(event.city, _permanentCities);
      final updated = await storageService.loadSelectedCities();
      emit(SelectedCityLoaded(updated));
    } catch (e) {
      emit(SelectedCityError("Failed to remove city: $e"));
    }
  }
}
