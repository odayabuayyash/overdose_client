import 'package:flutter/material.dart';

class RouteAnimation extends PageRouteBuilder {
  final Page;
  RouteAnimation({this.Page})
      : super(
            pageBuilder: (context, animation, animationtwo) => Page,
            transitionsBuilder: (context, animation, animationtwo, child) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: SizeTransition(
                  sizeFactor: animation,
                  child: child,
                ),
              );
            });
}
