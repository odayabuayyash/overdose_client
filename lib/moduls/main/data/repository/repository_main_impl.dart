import 'package:overdose/core/local_data_cache.dart/local_data_cache.dart';
import 'package:overdose/core/network/error_handler.dart';
import 'package:overdose/core/network/network_info.dart';
import 'package:overdose/core/network/requests.dart';
import 'package:overdose/core/remote_data_source/remote_data_source.dart';
import 'package:overdose/moduls/main/data/mappers/mappers.dart';
import 'package:overdose/moduls/main/data/responses/home_responses.dart';
import 'package:overdose/moduls/main/data/responses/order_response.dart';
import 'package:overdose/moduls/main/domain/models/home_models.dart';
import 'package:overdose/core/network/faileur.dart';
import 'package:dartz/dartz.dart';
import 'package:overdose/moduls/main/domain/models/notification_model.dart';
import 'package:overdose/moduls/main/domain/models/order_model.dart';
import 'package:overdose/moduls/main/domain/repository/repository_main.dart';

class MainRpositoryImpl implements MainRepository {
  final NetworkInfo _networkInfo;
  final RemoteDataSource _remoteDataSource;
  final LocalDataCaching _caching;
  MainRpositoryImpl(this._networkInfo, this._remoteDataSource, this._caching);
  @override
  Future<Either<Faileur, HomeData>> getHomeData() async {
    try {
      final response = await _caching.getHomeData();
      return Right(response.toDomain());
    } catch (cach_error) {
      if (await _networkInfo.isConnected == true) {
        try {
          var response = await _remoteDataSource.getHomeData();
          if (response.message == 'ok') {
            _caching.saveDataHome(response);
            return right(response.toDomain());
          } else {
            return Left(DataSource.DEFAULT.getFaileur());
          }
        } catch (e) {
          return left(ErrorHandler.handle(e).faileur);
        }
      } else {
        return Left(DataSource.NO_CONNECTION_INTERNET.getFaileur());
      }
    }
  }

  @override
  Future<Either<Faileur, SearchData>> search(String title) async {
    if (await _networkInfo.isConnected == true) {
      try {
        var response = await _remoteDataSource.search(title);
        if (response != null) {
          return right(response.toDomain());
        } else {
          return Left(DataSource.DEFAULT.getFaileur());
        }
      } catch (e) {
        return left(ErrorHandler.handle(e).faileur);
      }
    } else {
      return Left(DataSource.NO_CONNECTION_INTERNET.getFaileur());
    }
  }

  @override
  Future<Either<Faileur, String>> sendOrder(Map<String, dynamic> order) async {
    if (await _networkInfo.isConnected == true) {
      try {
        var response = await _remoteDataSource.sendOrder(order);
        if (response.message == 'OK') {
          return right(response.message ?? '');
        } else {
          return Left(DataSource.DEFAULT.getFaileur());
        }
      } catch (e) {
        return left(ErrorHandler.handle(e).faileur);
      }
    } else {
      return Left(DataSource.NO_CONNECTION_INTERNET.getFaileur());
    }
  }

  @override
  Future<Either<Faileur, Notifications>> getNotification() async {
    if (await _networkInfo.isConnected == true) {
      try {
        var response = await _remoteDataSource.getNotifications();
        if (response.message == 'OK') {
          return right(response.toDomain());
        } else {
          return Left(DataSource.DEFAULT.getFaileur());
        }
      } catch (e) {
        return left(ErrorHandler.handle(e).faileur);
      }
    } else {
      return Left(DataSource.NO_CONNECTION_INTERNET.getFaileur());
    }
  }

  @override
  Future<Either<Faileur, OrdersData>> getOrders(int id) async {
    if (await _networkInfo.isConnected == true) {
      try {
        var response = await _remoteDataSource.getOrders(id);
        if (response.message == 'OK') {
          return right(response.toDomain());
        } else {
          return Left(DataSource.DEFAULT.getFaileur());
        }
      } catch (e) {
        return left(ErrorHandler.handle(e).faileur);
      }
    } else {
      return Left(DataSource.NO_CONNECTION_INTERNET.getFaileur());
    }
  }

  @override
  Future<Either<Faileur, String>> updateProfil(
      UpdateProfilRequest updateProfilRequest) async {
    if (await _networkInfo.isConnected == true) {
      try {
        var response =
            await _remoteDataSource.updateProfil(updateProfilRequest);
        if (response.message == 'ok') {
          return right('');
        } else {
          return Left(DataSource.DEFAULT.getFaileur());
        }
      } catch (e) {
        return left(ErrorHandler.handle(e).faileur);
      }
    } else {
      return Left(DataSource.NO_CONNECTION_INTERNET.getFaileur());
    }
  }

  @override
  Future<Either<Faileur, String>> deleteProfil(int id) async {
    if (await _networkInfo.isConnected == true) {
      try {
        var response = await _remoteDataSource.deleteProfil(id);
        if (response.message == 'ok') {
          return right('');
        } else {
          return Left(DataSource.DEFAULT.getFaileur());
        }
      } catch (e) {
        return left(ErrorHandler.handle(e).faileur);
      }
    } else {
      return Left(DataSource.NO_CONNECTION_INTERNET.getFaileur());
    }
  }
}
