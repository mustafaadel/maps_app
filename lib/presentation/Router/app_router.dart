import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:maps_app/presentation/screens/map_screen.dart';
import 'package:maps_app/presentation/screens/otp_screen.dart';

import '../../constants/string_manager.dart';
import '../screens/login_screen.dart';

class AppRouter {
  PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();

  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreenRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: phoneAuthCubit,
                  child: LoginScreen(),
                ));
      case OtpScreenRoute:
        final phoneNumber = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: phoneAuthCubit,
                  child: OtpScreen(phoneNumber: phoneNumber),
                ));
      case MapScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const MapScreen(),
        );
      default:
        return null;
    }
  }
}
