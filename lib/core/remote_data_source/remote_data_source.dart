import 'package:overdose/moduls/authentication/data/network/api_service_client.dart';
import 'package:overdose/core/network/requests.dart';
import 'package:overdose/moduls/main/data/network/api_service_client.dart';
import 'package:overdose/moduls/main/data/responses/home_responses.dart';
import 'package:overdose/moduls/main/data/responses/notification_response.dart';
import '../../moduls/authentication/data/responses/login_response.dart';
import '../../moduls/main/data/responses/order_response.dart';

abstract class RemoteDataSource {
  Future<SignupResponse> login(LoginRequest loginRequest);
  Future<SignupResponse> signup(SignupRequest signupRequest);
  Future<SignupResponse> check_email_phone(
      Check_email_phone_request checkRequest);
  Future<HomeResponse> getHomeData();
  Future<SearchResponse> search(String title);
  Future<SignupResponse> updateUser(UpdateUserRequest updateUserRequest);
  Future<OrderResponse> sendOrder(Map<String, dynamic> order);
  Future<NotificationsResponse> getNotifications();
  Future<OrdersDataResponse> getOrders(int id);
  Future<UpdateProfileResponse> updateProfil(
      UpdateProfilRequest updateProfilRequest);
  Future<UpdateProfileResponse> deleteProfil(int id);
  Future<ForgotPasswordResponse> checkPhoneForgout(String phone);
  Future<ForgotPasswordResponse> changePassword(
      ChangePasswordRequest changePasswordRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  ApiServiceClientAuth _apiServiceClient;
  ApiServicesClientMain _apiServicesClientMain;
  RemoteDataSourceImpl(this._apiServiceClient, this._apiServicesClientMain);
  @override
  Future<SignupResponse> login(LoginRequest loginRequest) async {
    return await _apiServiceClient.login(
        phone: loginRequest.phone,
        password: loginRequest.password,
        token: loginRequest.token);
  }

  @override
  Future<SignupResponse> signup(SignupRequest signupRequest) async {
    return await _apiServiceClient.signup(
        firstName: signupRequest.firstName,
        lastName: signupRequest.lastName,
        email: signupRequest.email,
        phone: signupRequest.phone,
        password: signupRequest.password,
        token: signupRequest.token);
  }

  @override
  Future<SignupResponse> check_email_phone(
      Check_email_phone_request checkRequest) async {
    return await _apiServiceClient.check_Phone_email(
        phone: checkRequest.phone,);
  }

  @override
  Future<HomeResponse> getHomeData() async {
    return await _apiServicesClientMain.getHomeData();
  }

  @override
  Future<SearchResponse> search(String title) async {
    return await _apiServicesClientMain.search(title);
  }

  @override
  Future<SignupResponse> updateUser(UpdateUserRequest updateUserRequest) async {
    return await _apiServiceClient.updateUser(
        id: updateUserRequest.id,
        f_name: updateUserRequest.f_name,
        l_name: updateUserRequest.l_name,
        email: updateUserRequest.email,
        password: updateUserRequest.password);
  }

  @override
  Future<OrderResponse> sendOrder(Map<String, dynamic> order) async {
    return await _apiServicesClientMain.sendOrder(order);
  }

  @override
  Future<NotificationsResponse> getNotifications() async {
    return await _apiServicesClientMain.getNotification();
  }

  @override
  Future<OrdersDataResponse> getOrders(int id) async {
    return await _apiServicesClientMain.getOrders(id);
  }

  @override
  Future<UpdateProfileResponse> updateProfil(
      UpdateProfilRequest updateProfileRequest) async {
    return await _apiServicesClientMain.updateProfil(
        updateProfileRequest.id,
        updateProfileRequest.f_name,
        updateProfileRequest.l_name,
        updateProfileRequest.password);
  }

  @override
  Future<UpdateProfileResponse> deleteProfil(int id) async {
    return await _apiServicesClientMain.deleteProfil(id);
  }

  @override
  Future<ForgotPasswordResponse> checkPhoneForgout(String phone) async {
    return await _apiServiceClient.checkPhoneForgout(phone);
  }

  @override
  Future<ForgotPasswordResponse> changePassword(
      ChangePasswordRequest changePasswordRequest) async {
    return await _apiServiceClient.changePassword(
        changePasswordRequest.phone, changePasswordRequest.password);
  }
}
