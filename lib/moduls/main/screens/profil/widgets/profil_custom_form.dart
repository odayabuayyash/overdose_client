import 'package:flutter/material.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/fonts_manager.dart';
import '../../../../../core/resources/styles_manager.dart';

Widget getProfilCustomForm(
    String hint,
    TextEditingController? controller,
    bool obscureText,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    bool readOnly) {
  return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorManager.grey2, borderRadius: BorderRadius.circular(40)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: TextFormField(
          readOnly: readOnly,
          keyboardType: keyboardType,
          validator: validator,
          obscureText: obscureText,
          controller: controller,
          style: getSemiBoldStyle(
              14, ColorManager.blackBlue, FontsConstants.cairo),
          decoration: InputDecoration(
            labelText: hint,
            labelStyle: getSemiBoldStyle(
                14, ColorManager.greyBlue, FontsConstants.cairo),
            constraints: BoxConstraints(maxHeight: 60, minHeight: 60),
            contentPadding: EdgeInsets.only(top: 12),
            errorStyle:
                getRegularStyle(10, ColorManager.reed, FontsConstants.cairo),
            // hintText: hint,
            border: InputBorder.none,
          ),
        ),
      ));
}
