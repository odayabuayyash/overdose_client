import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get_it/get_it.dart';
import 'package:overdose/core/common/public_widgets.dart/custom_button.dart';
import 'package:overdose/core/resources/color_manager.dart';
import 'package:overdose/core/resources/fonts_manager.dart';
import 'package:overdose/core/resources/styles_manager.dart';
import 'package:overdose/moduls/authentication/screens/forgot_password/change_password/view/change_password_view.dart';
import '../../../../../../app/dependency_injection.dart';
import '../../../../../../core/common/state_rendrer/state_rendrer_impl.dart';
import '../../../../../../core/resources/values_manager.dart';
import '../../../../domain/use_cases/use_cases.dart';
import '../../../signup/viewmodel/signup_viewmodel.dart';

class OtpForgotPasswordScreen extends StatefulWidget {
  String phone;
  String credincialID;
  OtpForgotPasswordScreen(
      {Key? key, required this.phone, required this.credincialID})
      : super(key: key);

  @override
  State<OtpForgotPasswordScreen> createState() =>
      _OtpForgotPasswordScreenState(phone, credincialID);
}

class _OtpForgotPasswordScreenState extends State<OtpForgotPasswordScreen> {
  String phone;
  String credincialID;
  _OtpForgotPasswordScreenState(this.phone, this.credincialID);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getContent(),
    );
  }

  Widget _getContent() {
    String firstNumber = phone.substring(0, 3);
    String lastNumber = phone.substring(phone.length - 2);
    final snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: Text('تم اعادة ارسال الرمز ',
            style: getSemiBoldStyle(
              14,
              ColorManager.white,
              FontsConstants.cairo,
            )));
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(
            right: AppSize.queryMargin, left: AppSize.queryMargin),
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Text(
              textAlign: TextAlign.center,
              "لقد أرسلنا رمز التحقق إلى هاتفك النقال",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 23, right: 23),
              child: Text(
                textAlign: TextAlign.center,
                "يرجى التحقق من رقم هاتفك المحمول $lastNumber ***** $firstNumber للاستمرار في إعادة تعيين كلمة المرور الخاصة بك",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            SizedBox(
              height: 55,
              width: double.infinity,
              child: OtpTextField(
                numberOfFields: 6,
                margin: const EdgeInsets.only(right: 4, left: 4),
                textStyle: getBoldStyle(
                    18, ColorManager.primary, FontsConstants.cairo),
                autoFocus: true,
                focusedBorderColor: ColorManager.primary,
                cursorColor: ColorManager.primary,
                filled: true,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                showFieldAsBox: true,
                keyboardType: TextInputType.phone,
                borderRadius: BorderRadius.circular(20),
                fieldWidth: 40.w,
                fillColor: ColorManager.grey2,
                onSubmit: (e) async {
                  final _auth = FirebaseAuth.instance;
                  showDialog(
                      context: context,
                      builder: ((context) => Dialog(
                          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                          elevation: 0,
                          child: showDialogLoading())));
                  try {
                    PhoneAuthCredential credincial =
                        PhoneAuthProvider.credential(
                            verificationId: credincialID, smsCode: e);
                    await _auth.signInWithCredential(credincial);
                    dimissDialog(context);
                    if (_auth.currentUser != null) {
                      // ignore: use_build_context_synchronously
                      changePasswordDI();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            ChangePasswordScreen(phone: phone),
                      ));
                    } else {
                      dimissDialog(context);
                      showToast(
                          "الرمز خاطأ . يارجى التاكد من الرمز و اعادة المحاولة",
                          duration: const Duration(seconds: 5),
                          context: context,
                          backgroundColor: ColorManager.reed,
                          textStyle: getSemiBoldStyle(
                              14, ColorManager.white, FontsConstants.cairo));
                    }
                  } catch (e) {
                    dimissDialog(context);
                    showToast(
                        "الرمز خاطأ . يارجى التاكد من الرمز و اعادة المحاولة",
                        duration: const Duration(seconds: 5),
                        context: context,
                        backgroundColor: ColorManager.reed,
                        textStyle: getSemiBoldStyle(
                            14, ColorManager.white, FontsConstants.cairo));
                  }
                },
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              "لم تستلم ؟",
              style:
                  getMediumStyle(14, ColorManager.grey1, FontsConstants.cairo),
            ),
            SizedBox(
              height: 20.h,
            ),
            getCustomButton(context, 'اعادة الارسال', () {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
