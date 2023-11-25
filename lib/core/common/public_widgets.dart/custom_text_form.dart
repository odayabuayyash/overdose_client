import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/fonts_manager.dart';
import '../../resources/styles_manager.dart';

Widget getCustomTextFormField(
    String hint,
    TextEditingController? controller,
    bool obscureText,
    String? Function(String?)? validator,
    TextInputType? keyboardType) {
  return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorManager.grey2, borderRadius: BorderRadius.circular(40)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: TextFormField(
          textDirection: TextDirection.ltr,
          keyboardType: keyboardType,
          validator: validator,
          textAlign: TextAlign.right,
          obscureText: obscureText,
          controller: controller,
          style:
              getSemiBoldStyle(16, ColorManager.primary, FontsConstants.cairo),
          decoration: InputDecoration(
              constraints: const BoxConstraints(maxHeight: 60, minHeight: 60),
              contentPadding: const EdgeInsets.only(top: 12),
              errorStyle:
                  getRegularStyle(10, ColorManager.reed, FontsConstants.cairo),
              hintText: hint,
              border: InputBorder.none,
              hintStyle: getSemiBoldStyle(
                  14, ColorManager.greyBlue, FontsConstants.cairo)),
        ),
      ));
}
