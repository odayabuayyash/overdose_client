import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overdose/app/shared_preferences.dart';
import 'package:overdose/core/local_data/my_sqflite.dart';
import 'package:overdose/core/local_data/remote_local_data.dart';
import 'package:overdose/core/local_data_cache.dart/local_data_cache.dart';
import 'package:overdose/core/network/network_info.dart';
import 'package:overdose/moduls/authentication/data/network/api_service_client.dart';
import 'package:overdose/core/remote_data_source/remote_data_source.dart';
import 'package:overdose/moduls/authentication/data/repository/repository_impl.dart';
import 'package:overdose/moduls/authentication/domain/repository/repository.dart';
import 'package:overdose/moduls/authentication/domain/use_cases/use_cases.dart';
import 'package:overdose/moduls/authentication/screens/forgot_password/change_password/viewmodel/change_password_viewmodel.dart';
import 'package:overdose/moduls/authentication/screens/forgot_password/forgot_password/viewmodel/forgot_password_viewmodel.dart';
import 'package:overdose/moduls/authentication/screens/login/viewmodel/login_viewmodel.dart';
import 'package:overdose/moduls/authentication/screens/signup/viewmodel/signup_viewmodel.dart';
import 'package:overdose/moduls/main/data/network/api_service_client.dart';
import 'package:overdose/moduls/main/data/repository/repository_main_impl.dart';
import 'package:overdose/moduls/main/domain/repository/repository_main.dart';
import 'package:overdose/moduls/main/domain/use_cases/use_caces.dart';
import 'package:overdose/moduls/main/screens/details_item/view_model/details_viewmodel.dart';
import 'package:overdose/moduls/main/screens/more_screens/notifications/viewmodel/notification_viewmodel.dart';
import 'package:overdose/moduls/main/screens/order/viewmodel/order_viewmodel.dart';
import 'package:overdose/moduls/main/screens/order_tracker/viewmodel/order_tracker_viewmodel.dart';
import 'package:overdose/moduls/main/screens/profil/view_model/profil_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../moduls/authentication/screens/signup/view/otp/viewmodel/otp_signup_viewmodel.dart';
import '../moduls/main/screens/home/view_model/home_viewmodel.dart';

final inectance = GetIt.instance;

Future<void> initApp() async {
  // shared pref
  final sharedPrefs = await SharedPreferences.getInstance();
  inectance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(sharedPrefs));
// local DB
  inectance.registerLazySingleton<MySqlite>(() => MySqliteImpl());
//local data source
  inectance.registerLazySingleton<RemoteLocalDataSource>(
      () => RemoteLocalDataSourceImpl());
  //caching data source
  inectance
      .registerLazySingleton<LocalDataCaching>(() => LocalDataCachingImpl());

// network info
  inectance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));
// api serice client DI
  inectance.registerLazySingleton<ApiServiceClientAuth>(
      () => ApiServiceClientAuthImpl());
  inectance.registerLazySingleton<ApiServicesClientMain>(
      () => ApiServicesClientMainIpml());
// remote datasource DI
  inectance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(
      inectance<ApiServiceClientAuth>(), inectance<ApiServicesClientMain>()));
// repository DI
  inectance.registerLazySingleton<AuthenticationRepository>(() =>
      AuthenticationRepositoryImpl(
          inectance<NetworkInfo>(), inectance<RemoteDataSource>()));
  inectance.registerLazySingleton<MainRepository>(() => MainRpositoryImpl(
      inectance<NetworkInfo>(),
      inectance<RemoteDataSource>(),
      inectance<LocalDataCaching>()));
}

loginDi() {
  if (!GetIt.I.isRegistered<LoginViewModel>()) {
    inectance.registerFactory<LoginUseCases>(
        () => LoginUseCases(inectance<AuthenticationRepository>()));
    inectance.registerFactory<LoginViewModel>(() => LoginViewModel(
        inectance<LoginUseCases>(), inectance<RemoteLocalDataSource>()));
  }
}

SignupDi() {
  if (!GetIt.I.isRegistered<SignupViewModel>()) {
    inectance.registerFactory<CheckPhoneUseCase>(
        () => CheckPhoneUseCase(inectance<AuthenticationRepository>()));
    inectance.registerFactory<SignupViewModel>(
        () => SignupViewModel(inectance<CheckPhoneUseCase>()));
  }
}

otpSignupDI() {
  if (!GetIt.I.isRegistered<OtpSignupViewModel>()) {
    inectance.registerFactory<SignupUseCases>(
        () => SignupUseCases(inectance<AuthenticationRepository>()));
    inectance.registerFactory<OtpSignupViewModel>(
        () => OtpSignupViewModel(inectance<SignupUseCases>()));
  }
}

HomeDI() {
  if (!GetIt.I.isRegistered<HomeViewModel>()) {
    inectance.registerFactory<HomeUseCace>(
        () => HomeUseCace(inectance<MainRepository>()));
    inectance.registerFactory<SearchUseCase>(
        () => SearchUseCase(inectance<MainRepository>()));
    inectance.registerFactory<HomeViewModel>(() => HomeViewModel(
        inectance<HomeUseCace>(),
        inectance<RemoteLocalDataSource>(),
        inectance<AppPreferences>(),
        inectance<SearchUseCase>()));
  }
}

itemDI() {
  if (!GetIt.I.isRegistered<DetailsViewModel>()) {
    inectance.registerFactory<DetailsViewModel>(
        () => DetailsViewModel(inectance<RemoteLocalDataSource>()));
  }
}

profilDI() {
  if (!GetIt.I.isRegistered<ProfilViewModel>()) {
    inectance.registerFactory<DeleteProfilUseCase>(
        () => DeleteProfilUseCase(inectance()));
    inectance.registerFactory<UpdateProfilUseCase>(
        () => UpdateProfilUseCase(inectance()));
    inectance.registerFactory<ProfilViewModel>(() => ProfilViewModel(
        inectance<RemoteLocalDataSource>(),
        inectance(),
        inectance(),
        inectance()));
  }
}

orderDI() {
  if (!GetIt.I.isRegistered<OrderViewModel>()) {
    inectance.registerFactory<OrderUseCace>(
      () => OrderUseCace(inectance<MainRepository>()),
    );
    inectance.registerFactory<OrderViewModel>(
        () => OrderViewModel(inectance<OrderUseCace>()));
  }
}

notificationDI() {
  if (!GetIt.I.isRegistered<NotificationViewModel>()) {
    inectance.registerFactory<NotificationsUseCace>(
      () => NotificationsUseCace(inectance<MainRepository>()),
    );
    inectance.registerFactory<NotificationViewModel>(
        () => NotificationViewModel(inectance<NotificationsUseCace>()));
  }
}

orderTrackerDI() {
  if (!GetIt.I.isRegistered<OrderTrackerViewModel>()) {
    inectance.registerFactory<OrderDataUseCase>(
      () => OrderDataUseCase(inectance<MainRepository>()),
    );
    inectance.registerFactory<OrderTrackerViewModel>(
        () => OrderTrackerViewModel(inectance(), inectance()));
  }
}

forgoutPasswordDI() {
  if (!GetIt.I.isRegistered<ForgotPasswordViewModel>()) {
    inectance.registerFactory<ForgoutPasswordUseCase>(
        () => ForgoutPasswordUseCase(inectance()));
    inectance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(inectance()));
  }
}

changePasswordDI() {
  if (!GetIt.I.isRegistered<ChangePasswordViewModel>()) {
    inectance.registerFactory<ChangePasswordUseCase>(
        () => ChangePasswordUseCase(inectance()));
    inectance.registerFactory<ChangePasswordViewModel>(
        () => ChangePasswordViewModel(inectance()));
  }
}
