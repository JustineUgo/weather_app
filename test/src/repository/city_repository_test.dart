import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/src/model/city_model.dart';
import 'package:weather/src/repository/city_repository.dart';

import '../../mock/mock_storage_service.dart';


class TestAssetBundle extends CachingAssetBundle {
  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    return '''
    [
      {"city": "Lagos", "lat": "6.4550", "lng": "3.3841"},
      {"city": "Abuja", "lat": "9.0667", "lng": "7.4833"},
      {"city": "Port Harcourt", "lat": "4.8242", "lng": "7.0336"},
      {"city": "Benin", "lat": "6.34", "lng": "5.62"}
    ]
    ''';
  }
  @override
  Future<ByteData> load(String key) async {
    return ByteData(0);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late CityRepository repository;
  late MockStorageService mockStorage;

  setUp(() {
    mockStorage = MockStorageService();
    repository = CityRepository(storageService: mockStorage);
    
  });

  test('loads cities from asset JSON', () async {
    final cities = await repository.loadCitiesFromAssets();
    
    expect(cities[0].city, 'Lagos');
    expect(cities.last.city, 'Suleja');
  });

  test('initializes selected cities if none exist', () async {
    final selectedCities = await repository.initSelectedCities();
    expect(selectedCities.length, 3);
    expect(selectedCities[0].city, 'Lagos');

    final stored = await mockStorage.loadSelectedCities();
    expect(stored.length, 3);
  });

  test('returns stored cities if already saved', () async {
    await mockStorage.saveSelectedCities([
      CityModel(city: 'Kano', lat: 12.0, lng: 8.5),
    ]);

    final selected = await repository.initSelectedCities();
    expect(selected.length, 1);
    expect(selected[0].city, 'Kano');
  });
}
