import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/fonts_manager.dart';
import '../../resources/styles_manager.dart';

Widget getSnackbar({required Color backgroundColor, required String message}) {
  return SnackBar(
      backgroundColor: backgroundColor,
      content: Text(message,
          style: getSemiBoldStyle(
            14,
            ColorManager.white,
            FontsConstants.cairo,
          )));
}
