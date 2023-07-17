import 'package:dartz/dartz.dart';
import 'package:overdose/core/network/faileur.dart';
import 'package:overdose/moduls/main/domain/models/home_models.dart';
import 'package:overdose/moduls/main/domain/models/notification_model.dart';
import 'package:overdose/moduls/main/domain/models/order_model.dart';

import '../../../../core/network/requests.dart';
import '../../data/responses/home_responses.dart';
import '../../data/responses/order_response.dart';

abstract class MainRepository {
  Future<Either<Faileur, HomeData>> getHomeData();
  Future<Either<Faileur, SearchData>> search(String title);
  Future<Either<Faileur, String>> sendOrder(Map<String, dynamic> order);
  Future<Either<Faileur, Notifications>> getNotification();
  Future<Either<Faileur, OrdersData>> getOrders(int id);
  Future<Either<Faileur, String>> updateProfil(
      UpdateProfilRequest updateProfilRequest);
  Future<Either<Faileur, String>> deleteProfil(int id);
}
