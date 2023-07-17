import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overdose/app/dependency_injection.dart';
import 'package:overdose/core/common/validator/validator_inputs.dart';
import 'package:overdose/core/resources/values_manager.dart';
import 'package:overdose/moduls/authentication/screens/forgot_password/change_password/viewmodel/change_password_viewmodel.dart';

import '../../../../../../core/common/public_widgets.dart/custom_button.dart';
import '../../../../../../core/common/public_widgets.dart/custom_text_form.dart';
import '../../../../../../core/resources/color_manager.dart';

class ChangePasswordScreen extends StatefulWidget {
  String phone;
  ChangePasswordScreen({Key? key, required this.phone}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState(phone);
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final ChangePasswordViewModel _changePasswordViewModel =
      inectance<ChangePasswordViewModel>();
  String phone;
  _ChangePasswordScreenState(this.phone);
  @override
  void initState() {
    _changePasswordViewModel.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getContent(),
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
          key: _changePasswordViewModel.formKey,
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              Text(
                "كلمة السر الجديدة",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(
                height: 12.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 23, right: 23),
                child: Text(
                  textAlign: TextAlign.center,
                  "قم باختيار كلمة مرور جديدة لحسابك",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              getCustomTextFormField(
                  "كلمة المرور",
                  _changePasswordViewModel.password1Controller,
                  false,
                  (e) => validatorInputs(e, 20, 6, "password"),
                  TextInputType.text),
              SizedBox(
                height: 20.h,
              ),
              getCustomTextFormField(
                  "اعادة كلمة المرور",
                  _changePasswordViewModel.password2Controller,
                  false,
                  (e) => validatorInputs(e, 20, 6, "password"),
                  TextInputType.text),
              SizedBox(
                height: 30.h,
              ),
              StreamBuilder<bool>(
                stream: _changePasswordViewModel.bottunStateOutput,
                builder: (context, snapshot) => Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: MaterialButton(
                        splashColor: const Color.fromARGB(255, 184, 124, 15),
                        onPressed: () {
                          _changePasswordViewModel.changePassword(
                              context, phone);
                        },
                        child: snapshot.data == false
                            ? Text(
                                "ارسال",
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            : const SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(
                                  color: ColorManager.white,
                                  strokeWidth: 2,
                                ),
                              )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _changePasswordViewModel.dispose();
    super.dispose();
  }
}
