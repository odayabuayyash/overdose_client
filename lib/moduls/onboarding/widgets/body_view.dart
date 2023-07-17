import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/color_manager.dart';
import '../view_model/onboarding_viewmodel.dart';

Widget bodyView(OnboardingViewModel onboardingViewModel) {
  return SizedBox(
    width: double.infinity,
    height: 130.h,
    child: PageView.builder(
      itemCount: getOnboardingData().length,
      physics: const NeverScrollableScrollPhysics(),
      controller: onboardingViewModel.controller2,
      // onPageChanged: (index) => onboardingViewModel.onChangePage(index),
      itemBuilder: (context, index) => FadeIn(
        animate: true,
        delay: const Duration(milliseconds: 300),
        duration: const Duration(milliseconds: 800),
        child: Container(
          width: double.infinity,
          height: 120.h,
          color: ColorManager.white,
          child: Column(
            children: [
              SizedBox(
                child: Text(
                  onboardingViewModel.data[index].title,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                    textAlign: TextAlign.center,
                    onboardingViewModel.data[index].subtitle,
                    style: Theme.of(context).textTheme.displaySmall),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
