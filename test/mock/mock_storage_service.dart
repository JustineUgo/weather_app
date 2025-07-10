import 'package:weather/src/model/city_model.dart';
import 'package:weather/service/storage_service.dart';

class MockStorageService implements StorageService {
  List<CityModel> _storedCities = [];

  @override
  Future<List<CityModel>> loadSelectedCities() async => _storedCities;

  @override
  Future<void> saveSelectedCities(List<CityModel> cities) async {
    _storedCities = List.from(cities);
  }

  @override
  Future<void> addCity(CityModel city) async {
    if (!_storedCities.any((c) => c.city == city.city)) {
      _storedCities.add(city);
    }
  }

  @override
  Future<void> removeCity(CityModel city, List<CityModel> permanentCities) async {
    if (permanentCities.any((c) => c.city == city.city)) return;
    _storedCities.removeWhere((c) => c.city == city.city);
  }

  @override
  Future<void> clearSelectedCities() async {
    _storedCities.clear();
  }

  @override
  Future<bool> hasStoredCities() async => _storedCities.isNotEmpty;
}
