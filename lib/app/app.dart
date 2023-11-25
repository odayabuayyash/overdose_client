import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overdose/core/resources/routes_manager.dart';
import 'package:overdose/core/resources/theme_manager.dart';
import 'package:overdose/moduls/splash_screen/splash_screen.dart';

class MyApp extends StatefulWidget {
  MyApp._interal();
  static final _inestance = MyApp._interal();
  factory MyApp() => _inestance;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        designSize: const Size(360, 690),
        splitScreenMode: true,
        builder: ((context, child) => MaterialApp(
              onGenerateRoute: RouteManager.getRoute,
              localizationsDelegates: const [
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale(
                  "ar",
                  "AE",
                ),
                Locale(
                  "En",
                  "en",
                ),
              ],
              locale: const Locale('en', 'En'),
              theme: getAppThemeData(),
              debugShowCheckedModeBanner: false,
              home: Directionality(
                  textDirection: TextDirection.rtl, child: SplashScreen()),
            )));
  }
}
