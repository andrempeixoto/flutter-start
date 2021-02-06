class WeatherData {
  final String city;
  final String description;
  final String temperature;

  WeatherData({this.city, this.description, this.temperature});

  // the function below creates one instance of the class that can be used all over
  factory WeatherData.fromJSON(Map<String, dynamic> json) {
    return WeatherData(
      city: json['name'],
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'],
    );
  }
}
