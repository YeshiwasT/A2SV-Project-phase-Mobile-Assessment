import '../entity/weather.dart';
import '../usecase/weather_usecase.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository(this.weatherApiClient);

  Future<List<Weather>> getWeatherForCity(String city) async {
    return weatherApiClient.getWeatherForCity(city);
  }
}
