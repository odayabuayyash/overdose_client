import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overdose/core/resources/color_manager.dart';

Widget getCustomButton(
    BuildContext context, String text, void Function()? function) {
  return Container(
    width: double.infinity,
    height: 56,
    decoration: BoxDecoration(
      color: ColorManager.primary,
      borderRadius: BorderRadius.circular(40),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: MaterialButton(
          splashColor: const Color.fromARGB(255, 184, 124, 15),
          onPressed: function,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall,
          )),
    ),
  );
}
