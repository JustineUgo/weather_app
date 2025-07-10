class WeatherResponse {
  Coord? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  num? visibility;
  Wind? wind;
  Clouds? clouds;
  num? dt;
  Sys? sys;
  num? timezone;
  num? id;
  String? name;
  num? cod;

  WeatherResponse({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      coord: json['coord'] != null ? Coord.fromJson(json['coord']) : null,
      weather: json['weather'] != null
          ? List<Weather>.from(json['weather'].map((x) => Weather.fromJson(x)))
          : null,
      base: json['base'],
      main: json['main'] != null ? Main.fromJson(json['main']) : null,
      visibility: json['visibility'],
      wind: json['wind'] != null ? Wind.fromJson(json['wind']) : null,
      clouds: json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null,
      dt: json['dt'],
      sys: json['sys'] != null ? Sys.fromJson(json['sys']) : null,
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }

  factory WeatherResponse.fixture() {
    return WeatherResponse.fromJson({
      "coord": {"lon": 3.3841, "lat": 6.455},
      "weather": [
        {
          "id": 802,
          "main": "Clouds",
          "description": "scattered clouds",
          "icon": "03d",
        },
      ],
      "base": "stations",
      "main": {
        "temp": 26.14,
        "feels_like": 26.14,
        "temp_min": 26.14,
        "temp_max": 26.14,
        "pressure": 1017,
        "humidity": 89,
        "sea_level": 1017,
        "grnd_level": 1016,
      },
      "visibility": 10000,
      "wind": {"speed": 5.14, "deg": 220},
      "clouds": {"all": 40},
      "dt": 1752136601,
      "sys": {
        "type": 1,
        "id": 1185,
        "country": "NG",
        "sunrise": 1752125845,
        "sunset": 1752170750,
      },
      "timezone": 3600,
      "id": 2332459,
      "name": "Lagos",
      "cod": 200,
    });
  }
}

class Coord {
  num? lon;
  num? lat;

  Coord({this.lon, this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(lon: (json['lon'] as num?), lat: (json['lat'] as num?));
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class Main {
  num? temp;
  num? feelsLike;
  num? tempMin;
  num? tempMax;
  num? pressure;
  num? humidity;
  num? seaLevel;
  num? grndLevel;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: (json['temp'] as num?),
      feelsLike: (json['feels_like'] as num?),
      tempMin: (json['temp_min'] as num?),
      tempMax: (json['temp_max'] as num?),
      pressure: json['pressure'] as num?,
      humidity: json['humidity'] as num?,
      seaLevel: json['sea_level'] as num?,
      grndLevel: json['grnd_level'] as num?,
    );
  }
}

class Wind {
  num? speed;
  num? deg;
  num? gust;

  Wind({this.speed, this.deg, this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: (json['speed'] as num?),
      deg: json['deg'],
      gust: (json['gust'] as num?),
    );
  }
}

class Clouds {
  num? all;

  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(all: json['all']);
  }
}

class Sys {
  String? country;
  num? sunrise;
  num? sunset;

  Sys({this.country, this.sunrise, this.sunset});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      country: json['country'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}
