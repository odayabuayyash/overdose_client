import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overdose/app/dependency_injection.dart';
import 'package:overdose/core/common/public_widgets.dart/custom_button.dart';
import 'package:overdose/core/resources/Strings_manager.dart';
import 'package:overdose/core/resources/color_manager.dart';
import 'package:overdose/core/resources/routes_manager.dart';
import 'package:overdose/moduls/onboarding/widgets/animated_container.dart';
import 'package:overdose/moduls/onboarding/widgets/body_view.dart';
import 'package:overdose/moduls/onboarding/widgets/images_view.dart';
import 'package:overdose/moduls/onboarding/view_model/onboarding_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final OnboardingViewModel _onboardingViewModel = OnboardingViewModel();
  final AppPreferences _preferences = inectance<AppPreferences>();
  @override
  void initState() {
    _onboardingViewModel.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SizedBox(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                SizedBox(
                  height: 80.h,
                ),
                imagesView(_onboardingViewModel),
                getAnimatedIndex(_onboardingViewModel),
                SizedBox(
                  height: 10.h,
                ),
                bodyView(_onboardingViewModel),
                SizedBox(
                  height: 30.h,
                ),
                getCustomButton(context, StringManager.next, () {
                  _onboardingViewModel.index == 2
                      ? {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              Routes.welcomeScreen, (route) => false),
                          _preferences.addIsSkepedOnboarding(true)
                        }
                      : _onboardingViewModel.onChangeIndex();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _onboardingViewModel.dispose();
    super.dispose();
  }
}
