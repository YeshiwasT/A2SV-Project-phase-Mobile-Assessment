import 'package:dartz/dartz.dart';
import 'package:mobile_assesment/feature/get_weathers/data/datasource/datasources.dart';
import 'package:mobile_assesment/feature/get_weathers/data/model/favorite_model.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entity/favorite.dart';
import '../../domain/repostory/favorite_repostory.dart';

class FavoriteRepositoryImpl extends FavoriteRepository {
  final FavoriteWeatherLocalDatasource localDatasource;
  FavoriteRepositoryImpl({
    required this.localDatasource,
  });

  @override
  Future<Either<Failure, void>> updateFavoriteWeather(
      {required Favorite favorite}) async {
    print("repostory implementation");
    try {
      final weatherModel = await localDatasource.cacheFavoriteWeather(
          favoriteModel: FavoriteModel(
              query: favorite.query,
              temperatureC: favorite.temperatureC,
              weatherIconUrl: favorite.weatherIconUrl));
      print("jjjjjjj");
      return Right(weatherModel);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Favorite>> getFavoriteWeather() async {
    print("repostory  get implementation");
    try {
      final weatherModel = await localDatasource.getFavoriteWeather();
      print(weatherModel);
      return Right(weatherModel);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
