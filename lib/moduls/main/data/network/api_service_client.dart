import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:overdose/moduls/main/data/responses/home_responses.dart';
import 'package:overdose/moduls/main/data/responses/notification_response.dart';
import 'package:overdose/moduls/main/data/responses/order_response.dart';

import '../../../../app/constants.dart';

abstract class ApiServicesClientMain {
  Future<HomeResponse> getHomeData();
  Future<SearchResponse> search(String title);
  Future<OrderResponse> sendOrder(Map<String, dynamic> order);
  Future<NotificationsResponse> getNotification();
  Future<OrdersDataResponse> getOrders(int id);
  Future<UpdateProfileResponse> updateProfil(
      int id, String f_name, String l_name, String password);
  Future<UpdateProfileResponse> deleteProfil(int id);
}

class ApiServicesClientMainIpml implements ApiServicesClientMain {
  Dio dio = Dio();
  ApiServicesClientMainIpml() {
    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      method: 'POST',
      sendTimeout: Constants.timeOut,
      receiveTimeout: Constants.timeOut,
      receiveDataWhenStatusError: true,
      extra: <String, dynamic>{},
      queryParameters: <String, dynamic>{},
    );
  }

  @override
  Future<HomeResponse> getHomeData() async {
    var response = await dio.get('/api/v1/products/all-products');
    return HomeResponse.fromJson(response.data);
  }

  @override
  Future<SearchResponse> search(String title) async {
    var response = await dio.get('/api/v1/products/search?name=$title');
    return SearchResponse.fromJson(response.data);
  }

  Map<String, dynamic>? queryParameters;
  @override
  Future<OrderResponse> sendOrder(Map<String, dynamic> order) async {
    var response = await dio.post(
      '/api/v1/customer/order/place',
      data: order,
    );

    var data = OrderResponse.fromJson({'status': response.data['status']});
    return data;
  }

  @override
  Future<NotificationsResponse> getNotification() async {
    var response = await dio.get('/api/v1/notifications');
    return NotificationsResponse.fromJson(response.data);
  }

  @override
  Future<OrdersDataResponse> getOrders(int id) async {
    var response = await dio.get(
        'https://control.overdoseshawarma.com/api/v1/customer/order/list/$id');
    var data = OrdersDataResponse.fromJson(response.data);
    return data;
  }

  @override
  Future<UpdateProfileResponse> updateProfil(
      int id, String f_name, String l_name, String password) async {
    var data = FormData.fromMap({
      "f_name": f_name,
      "l_name": l_name,
      "password": password,
      "user_id": id
    });
    var response =
        await dio.post('/api/v1/customer/update-profile', data: data);

    return UpdateProfileResponse.fromJson(response.data);
  }

  @override
  Future<UpdateProfileResponse> deleteProfil(int id) async {
    var data = FormData.fromMap({"user_id": id});
    var response =
        await dio.post("/api/v1/customer/remove-account", data: data);
    print(response);
    return UpdateProfileResponse.fromJson(response.data);
  }
}
