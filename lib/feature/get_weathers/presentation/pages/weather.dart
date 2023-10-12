import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_assesment/feature/get_weathers/presentation/widgets/weather_widget.dart';

import '../../domain/entity/weather.dart';
import '../bloc/weather_bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final WeatherBloc _weatherBloc = WeatherBloc();

  @override
  void dispose() {
    _weatherBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        bloc: _weatherBloc,
        builder: (context, state) {
          if (state is WeatherLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoaded) {
            return _buildWeatherList(state.weather);
          } else if (state is WeatherError) {
            return Text(state.error);
          } else {
            return Text('Unknown state');
          }
        },
      ),
    );
  }

  Widget _buildWeatherList(List<Weather> weather) {
    return ListView.builder(
      itemCount: weather.length,
      itemBuilder: (context, index) {
        return WeatherItem(weather[index]);
      },
    );
  }
}
