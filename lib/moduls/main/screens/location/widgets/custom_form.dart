import 'package:flutter/material.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/fonts_manager.dart';
import '../../../../../core/resources/styles_manager.dart';

Widget getCustomFormLocation(
    void Function()? onTap,
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
          keyboardType: keyboardType,
          validator: validator,
          obscureText: obscureText,
          controller: controller,
          style:
              getSemiBoldStyle(16, ColorManager.primary, FontsConstants.cairo),
          decoration: InputDecoration(
              suffixIcon: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: InkWell(
                  onTap: onTap,
                  child: Icon(
                    Icons.search_sharp,
                    color: ColorManager.primary,
                    size: 30,
                  ),
                ),
              ),
              constraints: BoxConstraints(maxHeight: 60, minHeight: 60),
              contentPadding: EdgeInsets.only(top: 12),
              errorStyle:
                  getRegularStyle(10, ColorManager.reed, FontsConstants.cairo),
              hintText: hint,
              border: InputBorder.none,
              hintStyle: getSemiBoldStyle(
                  14, ColorManager.greyBlue, FontsConstants.cairo)),
        ),
      ));
}
