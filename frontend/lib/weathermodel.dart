/// Represents the weather response data model.
/// The [WeatherResponse] class contains information about the location and current weather conditions.

class WeatherResponse {
  /// The location of the weather data.
  Location? location;

  /// The current weather conditions.
  Current? current;

  /// Creates a [WeatherResponse] instance.
  /// The [location] and [current] parameters are optional.

  WeatherResponse({this.location, this.current});

  /// Creates a [WeatherResponse] instance from a JSON object.
  /// The [json] parameter is a map representing the JSON object.

  WeatherResponse.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    current =
        json['current'] != null ? new Current.fromJson(json['current']) : null;
  }

  /// Converts the [WeatherResponse] instance to a JSON object.
  /// Returns a map representing the JSON object.

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.current != null) {
      data['current'] = this.current!.toJson();
    }
    return data;
  }
}

/// Represents the location data model.
/// The [Location] class contains information about the location.

class Location {
  /// The name of the location.
  String? name;

  /// Creates a [Location] instance.
  /// The [name] parameter is optional.
  Location({this.name});

  /// Creates a [Location] instance from a JSON object.
  /// The [json] parameter is a map representing the JSON object.

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  /// Converts the [Location] instance to a JSON object.
  /// Returns a map representing the JSON object.

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

/// Represents the current weather data model.
/// The [Current] class contains information about the current weather conditions.

class Current {
  /// The current temperature in Celsius.
  double? tempC;

  /// The current weather condition.
  Condition? condition;

  /// The current wind speed in kilometers per hour.
  double? windKph;

  /// The current humidity percentage.
  int? humidity;

  /// Creates a [Current] instance.
  /// The [tempC], [condition], [windKph], and [humidity] parameters are optional.

  Current({this.tempC, this.condition, this.windKph, this.humidity});

  /// Creates a [Current] instance from a JSON object.
  /// The [json] parameter is a map representing the JSON object.

  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
    windKph = json['wind_kph'];
    humidity = json['humidity'];
  }

  /// Converts the [Current] instance to a JSON object.
  /// Returns a map representing the JSON object.

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp_c'] = this.tempC;
    if (this.condition != null) {
      data['condition'] = this.condition!.toJson();
    }
    data['wind_kph'] = this.windKph;
    data['humidity'] = this.humidity;
    return data;
  }
}

/// Represents the weather condition data model.
/// The [Condition] class contains information about the weather condition.

class Condition {
  /// The text description of the weather condition.
  String? text;

  /// The icon URL of the weather condition.
  String? icon;

  /// The code representing the weather condition.
  int? code;

  /// Creates a [Condition] instance.
  /// The [text], [icon], and [code] parameters are optional.

  Condition({this.text, this.icon, this.code});

  /// Creates a [Condition] instance from a JSON object.
  /// The [json] parameter is a map representing the JSON object.

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
    code = json['code'];
  }

  /// Converts the [Condition] instance to a JSON object.
  /// Returns a map representing the JSON object.

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['icon'] = this.icon;
    data['code'] = this.code;
    return data;
  }
}
