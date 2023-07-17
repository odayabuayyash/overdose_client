import 'package:flutter/cupertino.dart';
import 'package:overdose/core/resources/fonts_manager.dart';

TextStyle _getstyle(
    FontWeight fontWeight, double size, Color color, String family) {
  return TextStyle(
      fontWeight: fontWeight, fontSize: size, color: color, fontFamily: family);
}

// extra bold style
getExtraBoldStyle(double size, Color color, String family) {
  return _getstyle(FontWeightManager.extraBold, size, color, family);
}
//  bold style

getBoldStyle(double size, Color color, String family) {
  return _getstyle(FontWeightManager.bold, size, color, family);
}
// semi bold style

getSemiBoldStyle(double size, Color color, String family) {
  return _getstyle(FontWeightManager.semiBold, size, color, family);
}
// medium style

getMediumStyle(double size, Color color, String family) {
  return _getstyle(FontWeightManager.medium, size, color, family);
}
// regular style

getRegularStyle(double size, Color color, String family) {
  return _getstyle(FontWeightManager.regular, size, color, family);
}
// light style

getLightStyle(double size, Color color, String family) {
  return _getstyle(FontWeightManager.light, size, color, family);
}
