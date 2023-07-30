import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maps_app/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:maps_app/constants/string_manager.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocProvider<PhoneAuthCubit>(
      create: (context) => PhoneAuthCubit(),
      child: ElevatedButton(
        onPressed: () async {
          // TODO : Navigate to next screen
          PhoneAuthCubit phoneAuthCubit = context.read<PhoneAuthCubit>();
          phoneAuthCubit.signOut();
          Navigator.pushReplacementNamed(context, LoginScreenRoute);
        },
        style: ElevatedButton.styleFrom(
            primary: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            minimumSize: const Size(100, 50)),
        child: Text(
          "Logout",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));
  }
}
