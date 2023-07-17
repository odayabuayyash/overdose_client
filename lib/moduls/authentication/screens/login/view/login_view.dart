import 'package:animate_do/animate_do.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overdose/core/common/public_widgets.dart/custom_button.dart';
import 'package:overdose/core/common/public_widgets.dart/custom_phone_input.dart';
import 'package:overdose/core/common/validator/validator_inputs.dart';
import 'package:overdose/core/resources/Strings_manager.dart';
import 'package:overdose/core/resources/color_manager.dart';
import 'package:overdose/core/resources/image_manager.dart';
import 'package:overdose/core/resources/routes_manager.dart';
import 'package:overdose/core/resources/values_manager.dart';
import 'package:overdose/moduls/authentication/screens/login/viewmodel/login_viewmodel.dart';
import 'package:overdose/moduls/main/screens/main/view/main_view.dart';
import '../../../../../app/dependency_injection.dart';
import '../../../../../core/common/public_widgets.dart/custom_text_form.dart';
import '../../../../../core/resources/fonts_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import 'package:overdose/core/common/state_rendrer/state_rendrer_impl.dart';

import '../../signup/viewmodel/signup_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginViewModel _loginViewModel = inectance<LoginViewModel>();

  _bind() async {
    _loginViewModel.start();
    _loginViewModel.isGoToSignupPageStream.stream.listen((event) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (event) {
          Navigator.pushReplacementNamed(context, Routes.signupScreen);
        }
      });
    });
    _loginViewModel.isGoToForgotPageStream.stream.listen((event) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (event) {
          Navigator.pushNamed(context, Routes.forgotScreen);
        }
      });
    });
    _loginViewModel.isValidToGoHomePageStream.stream.listen((event) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (event) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.mainScreen, (route) => false);
        }
      });
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: _loginViewModel.flowStateOutput,
          builder: (context, snapshot) =>
              snapshot.data?.getScreenWidget(_getContent(), context, () {}) ??
              _getContent()),
    );
  }

  Widget _getContent() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Scrollbar(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(
                left: AppSize.queryMargin, right: AppSize.queryMargin),
            child: Form(
              key: _loginViewModel.formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  FadeInUp(
                      delay: const Duration(milliseconds: 100),
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        StringManager.login,
                        style: Theme.of(context).textTheme.displayLarge,
                      )),
                  SizedBox(
                    height: 12.h,
                  ),
                  FadeInUp(
                      delay: const Duration(milliseconds: 150),
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        StringManager.signupBodyText,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                  SizedBox(
                    height: 40.h,
                  ),
                  FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 300),
                      child:
                          // getCustomTextFormField(
                          //     StringManager.phoneNumber,
                          //     _loginViewModel.phoneController,
                          //     false,
                          //     (e) => validatorInputs(e, 10, 10, 'phone'),
                          //     TextInputType.phone)
                          getCustomPhoneInput(
                              hint: StringManager.phoneNumber,
                              validator: (e) =>
                                  validatorInputs(e, 10, 10, 'phone'),
                              onInputChanged: (e) {
                                _loginViewModel.phoneNumber =
                                    e.phoneNumber.toString();
                                print(_loginViewModel.phoneNumber);
                              })),
                  SizedBox(
                    height: 30.h,
                  ),
                  FadeInUp(
                      delay: const Duration(milliseconds: 250),
                      duration: const Duration(milliseconds: 300),
                      child: getCustomTextFormField(
                          StringManager.password,
                          _loginViewModel.passwordController,
                          true,
                          (e) => validatorInputs(e, 20, 6, 'passwordLogin'),
                          TextInputType.text)),
                  SizedBox(
                    height: 30.h,
                  ),
                  FadeInUp(
                      delay: const Duration(milliseconds: 300),
                      duration: const Duration(milliseconds: 300),
                      child: getCustomButton(context, StringManager.signin, () {
                        _loginViewModel.login();
                      })),
                  SizedBox(
                    height: 20.h,
                  ),

                  FadeInUp(
                      delay: const Duration(milliseconds: 350),
                      duration: const Duration(milliseconds: 300),
                      child: InkWell(
                        onTap: () {
                          _loginViewModel.goToForgotPage();
                        },
                        child: Text(StringManager.forgotPassword,
                            style: Theme.of(context).textTheme.bodyMedium),
                      )),
                  SizedBox(
                    height: 30.h,
                  ),
                  // FadeInUp(
                  //     delay: const Duration(milliseconds: 400),
                  //     duration: const Duration(milliseconds: 300),
                  //     child: Text(StringManager.connectWith,
                  //         style: Theme.of(context).textTheme.bodyMedium)),
                  // SizedBox(
                  //   height: 30.h,
                  // ),

                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeInUp(
                            delay: const Duration(milliseconds: 400),
                            duration: const Duration(milliseconds: 300),
                            child: Text(StringManager.dontHaveAcount,
                                style: Theme.of(context).textTheme.bodyMedium)),
                        SizedBox(
                          width: 4.h,
                        ),
                        FadeInUp(
                            delay: const Duration(milliseconds: 600),
                            duration: const Duration(milliseconds: 300),
                            child: InkWell(
                              onTap: () {
                                _loginViewModel.goToSignupPage();
                              },
                              child: Text(StringManager.signup,
                                  style: getMediumStyle(
                                    16,
                                    ColorManager.primary,
                                    FontsConstants.cairo,
                                  )),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
    super.dispose();
  }
}
