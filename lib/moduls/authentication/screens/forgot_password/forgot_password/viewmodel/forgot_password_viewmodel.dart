import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overdose/core/bases/base_viewmodel.dart';
import 'package:overdose/core/common/state_rendrer/state_rendrer_impl.dart';
import 'package:overdose/moduls/authentication/domain/use_cases/use_cases.dart';
import 'package:overdose/moduls/authentication/screens/forgot_password/otp/view/otp_forgot_view.dart';
import 'package:rxdart/rxdart.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  final StreamController isValidToGo = BehaviorSubject<bool>();
  final ForgoutPasswordUseCase _useCase;
  final _auth = FirebaseAuth.instance;
  ForgotPasswordViewModel(this._useCase);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? phone;
  String verificationID = '';
  onChangePhoneValue(String? e) {
    phone = e;
    print(phone);
  }

  checkPhone(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      flowStateInput.add(LoadingStatePopUp());
      (await _useCase.excute(ForGoutInputs(phone!))).fold(
          (l) => {
                l.code == 404
                    ? flowStateInput
                        .add(ErrorStatePopUp('رقم الهاتف غير موجود'))
                    : flowStateInput.add(l.message)
              },
          (r) => {
                _auth.verifyPhoneNumber(
                    phoneNumber: phone,
                    verificationCompleted: (e) {},
                    verificationFailed: (e) {
                      flowStateInput
                          .add(ErrorStatePopUp("حدث خطا في ارسال رمز التاكيد"));
                    },
                    codeSent: (String verifivationID, int? resendCode) {
                      print('succceeees');
                      flowStateInput.add(ContentState());
                      verificationID = verifivationID;
                      isValidToGo.add(true);
                    },
                    codeAutoRetrievalTimeout: (e) {})
              });
    }
  }

  @override
  dispose() {
    flowStateController.close();
  }

  @override
  start() {}
}
