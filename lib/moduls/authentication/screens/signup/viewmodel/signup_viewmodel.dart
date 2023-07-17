import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:lottie/lottie.dart';
import 'package:overdose/core/bases/base_viewmodel.dart';
import 'package:overdose/core/common/state_rendrer/state_rendrer_impl.dart';
import 'package:overdose/core/resources/image_manager.dart';
import 'package:overdose/moduls/authentication/domain/use_cases/use_cases.dart';
import 'package:rxdart/subjects.dart';
import '../../../../../app/dependency_injection.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/fonts_manager.dart';
import '../../../../../core/resources/styles_manager.dart';

class SignupViewModel extends BaseViewModel with SignupInputs, SignupOutputs {
  final CheckPhoneUseCase _checkPhoneUseCase;
  SignupViewModel(this._checkPhoneUseCase);
  StreamController isValidToRegister = BehaviorSubject<bool>();
  StreamController isGoToLoginPage = BehaviorSubject<bool>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  String phoneNumber = '';
  String verificationID = '';
  String? fcmToken = '';
  final _auth = FirebaseAuth.instance;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  dispose() {
    flowStateController.close();
    inectance.unregister<SignupViewModel>();
    inectance.unregister<CheckPhoneUseCase>();
  }

  @override
  start() {}
  // methods

  @override
  goToLoginPage() {
    isGoToLoginPage.add(true);
  }

  @override
  signup(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (password1Controller.text == password2Controller.text) {
        flowStateInput.add(LoadingStatePopUp());

        fcmToken = await FirebaseMessaging.instance.getToken();
        if (fcmToken != null) {
          print(fcmToken);
          (await _checkPhoneUseCase.excute(
                  Check_Phone_email_inputs( phoneNumber)))
              .fold(
                  (faileur) =>
                      flowStateInput.add(ErrorStatePopUp(faileur.message)),
                  (success) => {
                        _auth.verifyPhoneNumber(
                            phoneNumber: phoneNumber,
                            verificationCompleted: (e) {},
                            verificationFailed: (e) {
                              flowStateInput.add(ErrorStatePopUp(
                                  "حدث خطا في ارسال رمز التاكيد"));
                            },
                            codeSent: (String verifivationID, int? resendCode) {
                              flowStateInput.add(ContentState());
                              verificationID = verifivationID;
                              isValidToRegister.add(true);
                            },
                            codeAutoRetrievalTimeout: (e) {})
                      });
        } else {
          flowStateInput.add(ErrorStatePopUp("لقد حدث خطأ اثناء الاتصال"));
        }
      } else {
        showToast(
          "كلمة المرور غير متطابقة",
          duration: const Duration(seconds: 3),
          position: StyledToastPosition.bottom,
          fullWidth: true,
          context: context,
          animation: StyledToastAnimation.scale,
          backgroundColor: ColorManager.reed,
          textStyle:
              getSemiBoldStyle(14, ColorManager.white, FontsConstants.cairo),
        );
      }
    }
  }
}

abstract class SignupInputs {
  signup(BuildContext context);
  goToLoginPage();
}

abstract class SignupOutputs {}

Widget showDialogLoading() {
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: Colors.transparent,
    child: Center(
      child: SizedBox(
        height: 120,
        width: 120,
        child: Lottie.asset(LottieManager.loading),
      ),
    ),
  );
}
