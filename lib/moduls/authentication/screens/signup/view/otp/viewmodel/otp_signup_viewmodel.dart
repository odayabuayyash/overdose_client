import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:overdose/core/resources/routes_manager.dart';
import 'package:overdose/moduls/authentication/domain/use_cases/use_cases.dart';
import '../../../../../../../app/dependency_injection.dart';
import '../../../../../../../core/bases/base_viewmodel.dart';
import '../../../../../../../core/common/state_rendrer/state_rendrer_impl.dart';
import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/fonts_manager.dart';
import '../../../../../../../core/resources/styles_manager.dart';

class OtpSignupViewModel extends BaseViewModel {
  final SignupUseCases _signupUseCases;
  OtpSignupViewModel(this._signupUseCases);
  completSignup(BuildContext context,
      {required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String password,
      required String token}) async {
    (await _signupUseCases.excute(SignupInput(
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
            password: password,
            token: token)))
        .fold(
            (faileur) => {
                  dimissDialog(context),
                  showToast("حدث خطأ اثناء التسجيل . يرجى المحاولة لاحقا",
                      duration: const Duration(seconds: 5),
                      context: context,
                      backgroundColor: ColorManager.reed,
                      textStyle: getSemiBoldStyle(
                          14, ColorManager.white, FontsConstants.cairo))
                },
            (success) => {
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.successScreen)
                });
  }

  @override
  dispose() {
    inectance.unregister<OtpSignupViewModel>();
    inectance.unregister<SignupUseCases>();
  }

  @override
  start() {
    // TODO: implement start
    throw UnimplementedError();
  }
}
