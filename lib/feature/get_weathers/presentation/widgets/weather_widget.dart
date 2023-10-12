import 'package:flutter/material.dart';

import '../../domain/entity/weather.dart';

class WeatherItem extends StatelessWidget {
  final Weather weather;

  const WeatherItem(this.weather, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(weather.city),
      subtitle: Text(weather.temperature.toString()),
      leading: Icon(Icons.wb_sunny),
    );
  }
}
