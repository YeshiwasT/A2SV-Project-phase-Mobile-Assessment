import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_assesment/feature/get_weathers/data/model/favorite_model.dart';
import 'package:mobile_assesment/feature/get_weathers/data/model/models.dart';
import 'package:mobile_assesment/feature/get_weathers/domain/entity/favorite.dart';

import '../../../../core/error/exception.dart';

abstract class FavoriteWeatherLocalDatasource {
  Future<void> cacheFavoriteWeather({
    required FavoriteModel favoriteModel,
  });
  Future<FavoriteModel> getFavoriteWeather();
  Future<void> initializeApp();
  Future<bool> getAppInitialization();
  // Future<void> updateWeatherModel({
  //   required WeatherModel updatedWeatherModelInformation,
  // });
}

class FavoriteWeatherLocalDatasourceImpl
    extends FavoriteWeatherLocalDatasource {
  final FlutterSecureStorage flutterSecureStorage;

  FavoriteWeatherLocalDatasourceImpl({
    required this.flutterSecureStorage,
  });
  final favoriteKey = "favorite";
  @override
  Future<void> cacheFavoriteWeather({
    required FavoriteModel favoriteModel,
  }) {
    print("in heer json incode ${favoriteModel.temperatureC}");
    String? stringfiedJson = json.encode(favoriteModel);
    print("to sssjson");
    print(stringfiedJson);
    return flutterSecureStorage.write(
      key: favoriteKey,
      value: stringfiedJson,
    );
  }

  @override
  Future<FavoriteModel> getFavoriteWeather() async {
    print(" ffffavorite");
    final userCredential = await flutterSecureStorage.read(key: favoriteKey);
    print(userCredential);

    if (userCredential != null) {
      return Future.value(
        FavoriteModel.fromLocalCachedJson(
          json.decode(userCredential),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> getAppInitialization() async {
    final initialized = await flutterSecureStorage.read(key: favoriteKey);
    if (initialized != null) {
      return true;
    }
    throw CacheException();
  }

  @override
  Future<void> initializeApp() {
    return flutterSecureStorage.write(key: favoriteKey, value: 'true');
  }
}
