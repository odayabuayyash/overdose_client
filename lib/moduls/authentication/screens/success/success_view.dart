import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:overdose/core/common/public_widgets.dart/custom_button.dart';
import 'package:overdose/core/resources/color_manager.dart';
import 'package:overdose/core/resources/fonts_manager.dart';
import 'package:overdose/core/resources/image_manager.dart';
import 'package:overdose/core/resources/routes_manager.dart';
import 'package:overdose/core/resources/styles_manager.dart';
import 'package:overdose/core/resources/values_manager.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(
              right: AppSize.queryMargin, left: AppSize.queryMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: SizedBox(),
              ),
              SizedBox(
                  height: 220.h,
                  width: 220.h,
                  child: Lottie.asset(LottieManager.success, repeat: false)),
              Text(
                "S U C C E S S",
                style: getBoldStyle(
                    30, ColorManager.primary, FontsConstants.cairo),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              getCustomButton(context, "تسجيل الدخول", () {
                Navigator.pushReplacementNamed(context, Routes.loginScreen);
              }),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
