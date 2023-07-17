import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overdose/core/resources/color_manager.dart';
import 'package:overdose/moduls/onboarding/view_model/onboarding_viewmodel.dart';

Widget imagesView(OnboardingViewModel onboardingViewModel) {
  return SizedBox(
    height: 313.h,
    child: PageView.builder(
      itemCount: getOnboardingData().length,
      physics: const NeverScrollableScrollPhysics(),

      controller: onboardingViewModel.controller1,
      // onPageChanged: (index) => onboardingViewModel.onChangePage(index),
      itemBuilder: (context, index) => FadeIn(
        animate: true,
        delay: const Duration(milliseconds: 200),
        duration: const Duration(milliseconds: 400),
        child: Container(
          height: 313.h,
          width: 210.w,
          color: ColorManager.white,
          child: Image.asset(onboardingViewModel.data[index].image),
        ),
      ),
    ),
  );
}
