import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overdose/core/resources/color_manager.dart';
import 'package:overdose/moduls/onboarding/view_model/onboarding_viewmodel.dart';

Widget getAnimatedIndex(OnboardingViewModel onboardingViewModel) {
  return SizedBox(
      height: 10.h,
      width: 60.w,
      child: StreamBuilder(
        stream: onboardingViewModel.getIndex,
        builder: (context, snapshot) => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 3, left: 3),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 10.h,
                width: 10.w,
                decoration: BoxDecoration(
                    color: snapshot.data == index
                        ? ColorManager.primary
                        : Color.fromARGB(255, 217, 217, 218),
                    borderRadius: BorderRadius.circular(100)),
              ),
            );
          },
        ),
      ));
}
