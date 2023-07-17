import 'package:dartz/dartz.dart';
import 'package:overdose/core/bases/base_usecase.dart';
import 'package:overdose/core/network/faileur.dart';
import 'package:overdose/core/network/requests.dart';
import 'package:overdose/moduls/main/domain/models/home_models.dart';
import 'package:overdose/moduls/main/domain/models/notification_model.dart';
import 'package:overdose/moduls/main/domain/models/order_model.dart';
import 'package:overdose/moduls/main/domain/repository/repository_main.dart';

class HomeUseCace extends BaseUseCase<HomeInpts, HomeData> {
  MainRepository _repositoryMain;
  HomeUseCace(this._repositoryMain);
  @override
  Future<Either<Faileur, HomeData>> excute(HomeInpts inputs) async {
    return await _repositoryMain.getHomeData();
  }
}

class SearchUseCase extends BaseUseCase<SearchInputs, SearchData> {
  MainRepository _repositoryMain;
  SearchUseCase(this._repositoryMain);
  @override
  Future<Either<Faileur, SearchData>> excute(SearchInputs inputs) async {
    return await _repositoryMain.search(inputs.title);
  }
}

class OrderUseCace extends BaseUseCase<OrderInputs, String> {
  MainRepository _repositoryMain;
  OrderUseCace(this._repositoryMain);
  @override
  Future<Either<Faileur, String>> excute(OrderInputs inputs) async {
    return await _repositoryMain.sendOrder(inputs.order);
  }
}

class NotificationsUseCace extends BaseUseCase<HomeInpts, Notifications> {
  MainRepository _repositoryMain;
  NotificationsUseCace(this._repositoryMain);
  @override
  Future<Either<Faileur, Notifications>> excute(HomeInpts inputs) async {
    return await _repositoryMain.getNotification();
  }
}

class OrderDataUseCase extends BaseUseCase<OrderDataInput, OrdersData> {
  MainRepository _repositoryMain;
  OrderDataUseCase(this._repositoryMain);
  @override
  Future<Either<Faileur, OrdersData>> excute(OrderDataInput inputs) async {
    return await _repositoryMain.getOrders(inputs.id);
  }
}

class UpdateProfilUseCase extends BaseUseCase<UpdateProfilInput, String> {
  MainRepository _repositoryMain;
  UpdateProfilUseCase(this._repositoryMain);
  @override
  Future<Either<Faileur, String>> excute(UpdateProfilInput inputs) async {
    return await _repositoryMain.updateProfil(UpdateProfilRequest(
        id: inputs.id,
        f_name: inputs.f_name,
        l_name: inputs.l_name,
        password: inputs.password));
  }
}

class DeleteProfilUseCase extends BaseUseCase<DeleteProdilInput, String> {
  MainRepository _repositoryMain;
  DeleteProfilUseCase(this._repositoryMain);
  @override
  Future<Either<Faileur, String>> excute(DeleteProdilInput inputs) async {
    return await _repositoryMain.deleteProfil(inputs.id);
  }
}

class UpdateProfilInput {
  int id;
  String f_name;
  String l_name;
  String password;
  UpdateProfilInput({
    required this.id,
    required this.f_name,
    required this.l_name,
    required this.password,
  });
}

class OrderDataInput {
  int id;
  OrderDataInput(this.id);
}

class DeleteProdilInput {
  int id;
  DeleteProdilInput(this.id);
}

class OrderInputs {
  Map<String, dynamic> order;
  OrderInputs(this.order);
}

class SearchInputs {
  String title;
  SearchInputs(this.title);
}

class HomeInpts {}
