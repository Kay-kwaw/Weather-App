class WeatherApi {
  WeatherApi({
    required this.coordinates,
    required this.name,
    required this.temperature,
    required this.humidity, 
    required this.weather,
  });

  Coordinates coordinates;
  List<Weather> weather;
  String name;
  double temperature;
  int humidity;

  factory WeatherApi.fromJson(Map<String, dynamic> json) {
    return WeatherApi(
      coordinates: Coordinates.fromJson(json['coord']),
      weather: List<Weather>.from(json['weather'].map((x) => Weather.fromJson(x))),
      name: json['name'] as String,
      temperature: (json['main']['temp'] as num).toDouble(),
      humidity: json['main']['humidity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coordinates': coordinates.toJson(),
      'weather': List<dynamic>.from(weather.map((x) => x.toJson())),
      'name': name,
    };
  }
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  int id;
  String main;
  String description;
  String icon;

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }
}

class Coordinates {
  Coordinates({
    required this.lon,
    required this.lat,
  });

  double lon;
  double lat;

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      lon: json['lon'],
      lat: json['lat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lon': lon,
      'lat': lat,
    };
  }
}
