import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/weather.dart';
import '../../domain/repostory/weather_repostory.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is GetWeatherEvent) {
      yield WeatherLoading();
      try {
        final weather = await weatherRepository.getWeatherForCity(event.city);
        yield WeatherLoaded(weather);
      } catch (e) {
        yield WeatherError(e.toString());
      }
    }
  }
}

class WeatherEvent {}

class GetWeatherEvent extends WeatherEvent {
  final String city;

  GetWeatherEvent(this.city);
}

class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final List<Weather> weather;

  WeatherLoaded(this.weather);
}

class WeatherError extends WeatherState {
  final String error;

  WeatherError(this.error);
}
