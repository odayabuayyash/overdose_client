import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:overdose/core/resources/Strings_manager.dart';
import 'package:overdose/core/resources/color_manager.dart';
import 'package:overdose/core/resources/fonts_manager.dart';
import 'package:overdose/core/resources/styles_manager.dart';

import '../../../../../core/resources/image_manager.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 35,
                        width: 25,
                        child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              size: 26,
                              color: ColorManager.blackBlue,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          "عن أوفردوز",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      SizedBox(
                        height: 37,
                        width: 27,
                        child: SvgPicture.asset('assets/images/card.svg'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                          height: 7,
                          width: 7,
                          decoration: BoxDecoration(
                              color: ColorManager.primary,
                              borderRadius: BorderRadius.circular(100)),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(StringManager.about1,
                            style: getRegularStyle(
                              14,
                              ColorManager.blackBlue,
                              FontsConstants.cairo,
                            )),
                      )
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                          height: 7,
                          width: 7,
                          decoration: BoxDecoration(
                              color: ColorManager.primary,
                              borderRadius: BorderRadius.circular(100)),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(StringManager.about2,
                            style: getRegularStyle(
                              14,
                              ColorManager.blackBlue,
                              FontsConstants.cairo,
                            )),
                      )
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                          height: 7,
                          width: 7,
                          decoration: BoxDecoration(
                              color: ColorManager.primary,
                              borderRadius: BorderRadius.circular(100)),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(StringManager.about3,
                                style: getRegularStyle(
                                  14,
                                  ColorManager.blackBlue,
                                  FontsConstants.cairo,
                                )),
                            Text(StringManager.about4,
                                style: getBoldStyle(
                                  14,
                                  ColorManager.blackBlue,
                                  FontsConstants.cairo,
                                )),
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
