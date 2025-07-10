import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:weather/service/storage_service.dart';
import 'package:weather/src/model/city_model.dart';

class CityRepository {
  final StorageService storageService;

  CityRepository({required this.storageService});

  Future<List<CityModel>> loadCitiesFromAssets() async {
    final String response = await rootBundle.loadString('assets/ng.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => CityModel.fromJson(json)).toList();
  }

  Future<List<CityModel>> initSelectedCities() async {
    final hasStored = await storageService.hasStoredCities();

    if (!hasStored) {
      final assetCities = await loadCitiesFromAssets();
      final defaultCities = assetCities.take(3).toList();
      await storageService.saveSelectedCities(defaultCities);
      return defaultCities;
    }

    return await storageService.loadSelectedCities();
  }
}
