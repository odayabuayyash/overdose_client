import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overdose/core/common/public_widgets.dart/custom_button.dart';
import 'package:overdose/core/resources/Strings_manager.dart';
import 'package:overdose/core/resources/color_manager.dart';
import 'package:overdose/core/resources/fonts_manager.dart';
import 'package:overdose/core/resources/image_manager.dart';
import 'package:overdose/core/resources/routes_manager.dart';
import 'package:overdose/core/resources/styles_manager.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 330.h,
                color: const Color.fromARGB(255, 248, 182, 58),
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.asset(
                    ImageManager.welcomeBackround,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                  top: 300,
                  right: 0,
                  left: 0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeInUp(
                        delay: const Duration(milliseconds: 200),
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: BorderRadius.circular(20)),
                          height: 114.h,
                          width: 143.w,
                          child: Image.asset(ImageManager.logo),
                        ),
                      ),
                    ],
                  )),
              Positioned(
                  bottom: 20,
                  left: 30,
                  right: 30,
                  child: SizedBox(
                    width: double.infinity,
                    height: 230.h,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: FadeInUp(
                              delay: const Duration(milliseconds: 300),
                              duration: const Duration(milliseconds: 300),
                              child: Text(
                                textAlign: TextAlign.center,
                                StringManager.description,
                                style: Theme.of(context).textTheme.displaySmall,
                              )),
                        ),
                        SizedBox(
                          height: 60.h,
                        ),
                        FadeInUp(
                            delay: const Duration(milliseconds: 400),
                            duration: const Duration(milliseconds: 300),
                            child: getCustomButton(
                                context, StringManager.signin, () {
                              Navigator.pushNamed(context, Routes.loginScreen);
                            })),
                        SizedBox(
                          height: 20.h,
                        ),
                        FadeInUp(
                            delay: const Duration(milliseconds: 500),
                            duration: const Duration(milliseconds: 300),
                            child: Container(
                                height: 56,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        color: ColorManager.primary, width: 1)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, Routes.signupScreen);
                                    },
                                    child: Text(
                                      StringManager.signup,
                                      style: getSemiBoldStyle(
                                        16,
                                        ColorManager.primary,
                                        FontsConstants.cairo,
                                      ),
                                    ),
                                  ),
                                )))
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
