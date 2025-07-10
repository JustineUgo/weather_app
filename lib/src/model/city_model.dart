class CityModel {
  String? city;
  num? lat;
  num? lng;
  String? country;
  String? iso2;
  String? adminName;
  String? capital;
  num? population;
  num? populationProper;

  CityModel({
    this.city,
    this.lat,
    this.lng,
    this.country,
    this.iso2,
    this.adminName,
    this.capital,
    this.population,
    this.populationProper,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      city: json['city'],
      lat: num.tryParse(json['lat'] ?? ''),
      lng: num.tryParse(json['lng'] ?? ''),
      country: json['country'],
      iso2: json['iso2'],
      adminName: json['admin_name'],
      capital: json['capital'],
      population: num.tryParse(json['population'] ?? ''),
      populationProper: num.tryParse(json['population_proper'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'lat': lat?.toString(),
      'lng': lng?.toString(),
      'country': country,
      'iso2': iso2,
      'admin_name': adminName,
      'capital': capital,
      'population': population?.toString(),
      'population_proper': populationProper?.toString(),
    };
  }
}
