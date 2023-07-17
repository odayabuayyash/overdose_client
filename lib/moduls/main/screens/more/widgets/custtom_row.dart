import 'package:flutter/material.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/fonts_manager.dart';
import '../../../../../core/resources/styles_manager.dart';

Widget custtomRow(void Function()? onTap, String image, String title) {
  return SizedBox(
    height: 85,
    width: double.infinity,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: ColorManager.grey2,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 207, 209, 209),
                        borderRadius: BorderRadius.circular(200)),
                    child: Transform.scale(
                        scaleX: -1,
                        child: Image.asset(
                          image,
                        )),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    title,
                    style: getSemiBoldStyle(
                        14, ColorManager.blackBlue, FontsConstants.cairo),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                color: ColorManager.grey2,
                borderRadius: BorderRadius.circular(200)),
            child: const Icon(
              Icons.arrow_forward_ios,
              color: ColorManager.blackBlue,
            ),
          ),
        )
      ],
    ),
  );
}
