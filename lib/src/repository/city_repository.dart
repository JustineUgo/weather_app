import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:weather/src/model/city_model.dart';

class CityRepository {
  Future<List<CityModel>> loadCitiesFromAssets() async {
    final String response = await rootBundle.loadString('assets/ng.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => CityModel.fromJson(json)).toList();
  }
}
