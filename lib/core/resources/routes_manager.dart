import 'package:flutter/material.dart';
import 'package:overdose/app/dependency_injection.dart';
import 'package:overdose/core/common/route_animation/route_animation.dart';
import 'package:overdose/moduls/authentication/screens/forgot_password/forgot_password/view/forgot_password_view.dart';
import 'package:overdose/moduls/authentication/screens/login/view/login_view.dart';
import 'package:overdose/moduls/authentication/screens/signup/view/otp/view/otp_signup_view.dart';
import 'package:overdose/moduls/authentication/screens/signup/view/signup_view/signup_view.dart';
import 'package:overdose/moduls/authentication/screens/success/success_view.dart';
import 'package:overdose/moduls/authentication/screens/welcome/view/welcome_view.dart';
import 'package:overdose/moduls/main/screens/home/view/home_view.dart';
import 'package:overdose/moduls/main/screens/location/view/location_view.dart';
import 'package:overdose/moduls/main/screens/main/view/main_view.dart';
import 'package:overdose/moduls/main/screens/more_screens/about/about_view.dart';
import 'package:overdose/moduls/main/screens/profil/view/profil_view.dart';
import 'package:overdose/moduls/onboarding/view/onboarding_view.dart';
import 'package:overdose/moduls/splash_screen/splash_screen.dart';

import '../../moduls/main/screens/order/view/success_order.dart';

class Routes {
  static const String splashScreen = "/";
  static const String onboardingScreen = "/onboardingScreen";
  static const String welcomeScreen = "/welcomeScreen";
  static const String loginScreen = "/loginScreen";
  static const String signupScreen = "/signupScreen";
  static const String forgotScreen = "/forgotScreen";
  static const String otpSignupScreen = "/otpSignupScreen";
  static const String homeScreen = "/homeScreen";
  static const String successScreen = "/successScreen";
  static const String successOrder = "/successOrder";
  static const String cardScreen = "/cardScreen";
  static const String locationScreen = "/locationScreen";
  static const String moreScreen = "/moreScreen";
  static const String aboutScreen = "/aboutScreen";
  static const String notificationScreen = "/notificationScreen";
  static const String profilScreen = "/profilScreen";
  static const String mainScreen = "/mainScreen";
}

class RouteManager {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case Routes.onboardingScreen:
        return RouteAnimation(Page: OnboardingScreen());
      case Routes.welcomeScreen:
        return RouteAnimation(Page: const WelcomeScreen());
      case Routes.loginScreen:
        loginDi();
        return RouteAnimation(Page: LoginScreen());
      case Routes.signupScreen:
        SignupDi();
        return RouteAnimation(Page: SignupScreen());
      case Routes.forgotScreen:
        forgoutPasswordDI();
        return RouteAnimation(Page: ForgotPasswordScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.mainScreen:
        HomeDI();
        profilDI();
        notificationDI();
        orderTrackerDI();
        return RouteAnimation(Page: MainScreen());

      case Routes.profilScreen:
        return MaterialPageRoute(builder: (_) => ProfilScreen());
      case Routes.aboutScreen:
        return MaterialPageRoute(builder: (_) => AboutScreen());

      case Routes.successScreen:
        return MaterialPageRoute(builder: (_) => const SuccessScreen());
      case Routes.successOrder:
        return MaterialPageRoute(builder: (_) => const SuccessOrderScreen());

      default:
        return RouteAnimation(Page: SplashScreen());
    }
  }
}
