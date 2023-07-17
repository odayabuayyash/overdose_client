import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overdose/app/dependency_injection.dart';
import 'package:overdose/core/common/public_widgets.dart/custom_button.dart';
import 'package:overdose/core/common/public_widgets.dart/custom_phone_input.dart';
import 'package:overdose/core/common/state_rendrer/state_rendrer_impl.dart';
import 'package:overdose/core/common/validator/validator_inputs.dart';
import 'package:overdose/core/resources/Strings_manager.dart';
import 'package:overdose/core/resources/values_manager.dart';
import 'package:overdose/moduls/authentication/screens/forgot_password/forgot_password/viewmodel/forgot_password_viewmodel.dart';

import '../../otp/view/otp_forgot_view.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final ForgotPasswordViewModel _forgotPasswordViewModel =
      inectance<ForgotPasswordViewModel>();

  bind() {
    _forgotPasswordViewModel.isValidToGo.stream.listen((event) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (event) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => OtpForgotPasswordScreen(
                    phone: _forgotPasswordViewModel.phone!,
                    credincialID: _forgotPasswordViewModel.verificationID),
              ));
        }
      });
    });
  }

  @override
  void initState() {
    bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _forgotPasswordViewModel.flowStateOutput,
        builder: (context, snapshot) =>
            snapshot.data?.getScreenWidget(_getContent(), context, () {
              _forgotPasswordViewModel.checkPhone(context);
            }) ??
            _getContent(),
      ),
    );
  }

  Widget _getContent() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(
            right: AppSize.queryMargin, left: AppSize.queryMargin),
        child: Form(
          key: _forgotPasswordViewModel.formKey,
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              Text(
                "إعادة تعيين كلمة المرور",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(
                height: 12.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 23, right: 23),
                child: Text(
                  textAlign: TextAlign.center,
                  "الرجاء إدخال الرقم الخاص بك لتلقي رابط لإنشاء كلمة مرور جديدة عبر رقمك ",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              getCustomPhoneInput(
                  hint: StringManager.phoneNumber,
                  validator: (e) => validatorInputs(
                      e?.replaceAll(new RegExp(r"\s+\b|\b\s"), ""),
                      10,
                      10,
                      "phone"),
                  onInputChanged: (e) {
                    _forgotPasswordViewModel.onChangePhoneValue(e.phoneNumber
                        ?.replaceAll(new RegExp(r"\s+\b|\b\s"), ""));
                  }),
              SizedBox(
                height: 30.h,
              ),
              getCustomButton(context, "ارسال", () {
                _forgotPasswordViewModel.checkPhone(context);
              })
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _forgotPasswordViewModel.dispose();
    super.dispose();
  }
}
