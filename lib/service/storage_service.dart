import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/src/model/city_model.dart';


class StorageService {
  static const String _selectedCitiesKey = 'selected_cities';

  Future<List<CityModel>> loadSelectedCities() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_selectedCitiesKey);

    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => CityModel.fromJson(e)).toList();
  }

  Future<void> saveSelectedCities(List<CityModel> cities) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = cities.map((c) => c.toJson()).toList();
    final jsonString = json.encode(jsonList);
    await prefs.setString(_selectedCitiesKey, jsonString);
  }

  Future<void> addCity(CityModel city) async {
    final cities = await loadSelectedCities();

    // Avoid duplicates
    if (!cities.any((c) => c.city == city.city)) {
      cities.add(city);
      await saveSelectedCities(cities);
    }
  }

  Future<void> removeCity(CityModel city, List<CityModel> permanentCities) async {
    final cities = await loadSelectedCities();

    // Prevent removing permanent cities
    final isPermanent = permanentCities.any((c) => c.city == city.city);
    if (isPermanent) return;

    cities.removeWhere((c) => c.city == city.city);
    await saveSelectedCities(cities);
  }

  Future<void> clearSelectedCities() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_selectedCitiesKey);
  }

  Future<bool> hasStoredCities() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_selectedCitiesKey);
  }
}
