import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:overdose/core/bases/base_viewmodel.dart';
import 'package:overdose/core/common/state_rendrer/state_rendrer_impl.dart';
import 'package:overdose/core/local_data/remote_local_data.dart';
import 'package:overdose/moduls/authentication/domain/use_cases/use_cases.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../app/dependency_injection.dart';
import '../../../../../app/shared_preferences.dart';

class LoginViewModel extends BaseViewModel with LoginInputs, LoginOutputs {
  final LoginUseCases _loginUseCases;
  final RemoteLocalDataSource _dataSource;
  final AppPreferences _preferences = inectance<AppPreferences>();
  LoginViewModel(this._loginUseCases, this._dataSource);

  //streams
  final StreamController isValidToGoHomePageStream = StreamController<bool>();
  final StreamController isGoToForgotPageStream = BehaviorSubject<bool>();
  final StreamController isGoToSignupPageStream = StreamController<bool>();
  // text form controllers
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String phoneNumber = '';

  @override
  dispose() {
    isGoToForgotPageStream.close();
    isGoToSignupPageStream.close();
    isValidToGoHomePageStream.close();
  }

  @override
  start() {
    isValidToGoHomePageStream.sink;
    isGoToForgotPageStream.sink;
    isGoToSignupPageStream.sink;
  }

  // methods

  @override
  login() async {
    if (formKey.currentState!.validate()) {
      flowStateInput.add(LoadingStatePopUp());

      final fcmToken = await FirebaseMessaging.instance.getToken();
      // final fcmToken = '';
      if (fcmToken != null) {
        (await _loginUseCases.excute(LoginInput(
                phone: phoneNumber,
                password: passwordController.text,
                token: fcmToken)))
            .fold(
                (faileur) =>
                    {flowStateInput.add(ErrorStatePopUp(faileur.message))},
                (success) => {
                      saveUser(
                          success.user!.id,
                          success.user!.firstName,
                          success.user!.lastName,
                          success.user!.email,
                          success.user!.phone,
                          fcmToken)
                    });
      } else {
        flowStateInput.add(ErrorStatePopUp("error token"));
      }
    }
  }

  saveUser(int id, String firstName, String lastName, String email,
      String phone, String token) async {
    int response = await _dataSource.onInsertUser(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        token: token);
    if (response > 0) {
      _preferences.addIsLogin(true);
      isValidToGoHomePageStream.add(true);
    }
    flowStateInput.add(ErrorStatePopUp('حدث خطا في حفظ بيانات التسجيل'));
  }

  @override
  loginWithFacebook() {
    // TODO: implement loginWithFacebook
    throw UnimplementedError();
  }

  @override
  loginWithGoogle() {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }

  @override
  goToForgotPage() {
    isGoToForgotPageStream.add(true);
  }

  @override
  goToSignupPage() async {
    isGoToSignupPageStream.add(true);
  }
}

abstract class LoginInputs {
  login();
  loginWithFacebook();
  loginWithGoogle();
  goToForgotPage();
  goToSignupPage();
}

abstract class LoginOutputs {}
