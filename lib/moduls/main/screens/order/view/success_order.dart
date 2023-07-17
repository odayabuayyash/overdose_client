import 'package:flutter/material.dart';
import 'package:overdose/core/common/public_widgets.dart/custom_button.dart';
import 'package:overdose/core/resources/color_manager.dart';
import 'package:overdose/core/resources/fonts_manager.dart';
import 'package:overdose/core/resources/image_manager.dart';
import 'package:overdose/core/resources/routes_manager.dart';
import 'package:overdose/core/resources/styles_manager.dart';

class SuccessOrderScreen extends StatelessWidget {
  const SuccessOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(right: 30, left: 30),
          child: Column(
            children: [
              const Expanded(
                child: SizedBox(),
              ),
              SizedBox(
                height: 255,
                width: 224,
                child: Image.asset(ImageManager.succesOrder),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                textAlign: TextAlign.center,
                'شكراً !',
                style: getBoldStyle(
                    26, ColorManager.blackBlue, FontsConstants.cairo),
              ),
              Text(
                textAlign: TextAlign.center,
                'لطلبك من أوفردوز',
                style: getBoldStyle(
                    18, ColorManager.blackBlue, FontsConstants.cairo),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                textAlign: TextAlign.center,
                'طلبك قيد المعالجة الآن. سنخبرك بمجرد اختيار الطلب من المنفذ. عند التحقق من حالة طلبك',
                style: getRegularStyle(
                    14, ColorManager.grey1, FontsConstants.cairo),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              getCustomButton(context, "العودة للصفحة الرئيسية", () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.mainScreen, (route) => false);
              }),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
