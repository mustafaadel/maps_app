import 'package:flutter/material.dart';
import 'package:maps_app/presentation/screens/otp_screen.dart';

import '../../constants/string_manager.dart';
import '../screens/login_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreenRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case OtpScreenRoute:
        return MaterialPageRoute(builder: (_) => OtpScreen());
      default:
        return null;
    }
  }
}
