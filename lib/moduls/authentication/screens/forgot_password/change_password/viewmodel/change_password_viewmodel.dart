import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:overdose/core/bases/base_viewmodel.dart';
import 'package:overdose/core/resources/routes_manager.dart';
import 'package:overdose/moduls/authentication/domain/use_cases/use_cases.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/fonts_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';

class ChangePasswordViewModel extends BaseViewModel
    with ChangePasswordinpt, ChangePasswordout {
  ChangePasswordUseCase _changePasswordUseCase;
  ChangePasswordViewModel(this._changePasswordUseCase);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  final StreamController _buttonStateController = BehaviorSubject<bool>();

  changePassword(BuildContext context, String phone) async {
    if (formKey.currentState!.validate()) {
      if (password1Controller.text == password2Controller.text) {
        bottunStateInput.add(true);
        (await _changePasswordUseCase
                .excute(ChangePasswordInputs(phone, password1Controller.text)))
            .fold(
                (l) => {
                      showToast("حدث خطا في تغيير كلمة المرور . اعد المحاولة",
                          duration: const Duration(seconds: 5),
                          context: context,
                          backgroundColor: ColorManager.reed,
                          textStyle: getSemiBoldStyle(
                              14, ColorManager.white, FontsConstants.cairo)),
                      bottunStateInput.add(false),
                    },
                (r) => {
                      bottunStateInput.add(false),
                      Navigator.of(context)
                          .pushReplacementNamed(Routes.successScreen),
                    });
      } else {
        showToast("كلمة المرور غير متطابقة",
            duration: const Duration(seconds: 5),
            context: context,
            backgroundColor: ColorManager.reed,
            textStyle:
                getSemiBoldStyle(14, ColorManager.white, FontsConstants.cairo));
      }
    }
  }

  @override
  dispose() {}

  @override
  start() {
    bottunStateInput.add(false);
  }

  @override
  Sink get bottunStateInput => _buttonStateController.sink;

  @override
  Stream<bool> get bottunStateOutput =>
      _buttonStateController.stream.map((event) => event);
}

abstract class ChangePasswordinpt {
  Sink get bottunStateInput;
}

abstract class ChangePasswordout {
  Stream<bool> get bottunStateOutput;
}
