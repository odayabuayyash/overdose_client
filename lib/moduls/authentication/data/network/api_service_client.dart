import 'package:dio/dio.dart';
import 'package:overdose/app/dependency_injection.dart';
import 'package:overdose/moduls/authentication/data/responses/login_response.dart';

import '../../../../app/constants.dart';

abstract class ApiServiceClientAuth {
  Future<SignupResponse> login(
      {required String phone, required String password, required String token});
  Future<SignupResponse> signup(
      {required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String password,
      required String token});
  Future<SignupResponse> check_Phone_email(
      {required String phone,});
  Future<SignupResponse> updateUser(
      {required int id,
      required String f_name,
      required String l_name,
      required String email,
      required String password});
  Future<ForgotPasswordResponse> checkPhoneForgout(String phone);
  Future<ForgotPasswordResponse> changePassword(String phone, String password);
}

class ApiServiceClientAuthImpl implements ApiServiceClientAuth {
  Dio dio = Dio();
  ApiServiceClientAuthImpl() {
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
  Future<SignupResponse> login(
      {required String phone,
      required String password,
      required String token}) async {
    var data = FormData.fromMap(
        {'email': phone, 'password': password, 'token': token});
    var response = await dio.post('/api/v1/auth/login', data: data);
    return SignupResponse.fromJson(response.data);
  }

  @override
  Future<SignupResponse> signup(
      {required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String password,
      required String token}) async {
    var data = FormData.fromMap({
      'f_name': firstName,
      'l_name': lastName,
      'email': email,
      'phone': phone,
      'password': password,
      'token': token
    });
    var response = await dio.post('/api/v1/auth/registration', data: data);

    return SignupResponse.fromJson(response.data);
  }

  @override
  Future<SignupResponse> check_Phone_email(
      {required String phone,}) async {
    var data = FormData.fromMap({
      'phone': phone,
    });
    var response =
        await dio.post('/api/v1/auth/verify-email-phone', data: data);
    return SignupResponse.fromJson(response.data);
  }

  @override
  Future<SignupResponse> updateUser(
      {required int id,
      required String f_name,
      required String l_name,
      required String email,
      required String password}) async {
    var data = FormData.fromMap({
      'f_name': f_name,
      'l_name': l_name,
      'email': email,
      'password': password,
      'user_id': id
    });
    var response = await dio.put('/api/v1/customer/update-profile', data: data);
    return SignupResponse.fromJson(response.data);
  }

  @override
  Future<ForgotPasswordResponse> checkPhoneForgout(String phone) async {
    var data = FormData.fromMap({
      'phone': phone,
    });
    var response =
        await dio.post('/api/v1/auth/forgot-password-change', data: data);

    return ForgotPasswordResponse.fromJson(response.data);
  }

  @override
  Future<ForgotPasswordResponse> changePassword(
      String phone, String password) async {
    var data = FormData.fromMap({'phone': phone, 'password': password});
    var response =
        await dio.post('/api/v1/auth/new-reset-password', data: data);
    return ForgotPasswordResponse.fromJson(response.data);
  }
}
