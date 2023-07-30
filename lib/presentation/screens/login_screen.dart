import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maps_app/presentation/widgets/phone_form_field.dart';

import '../../constants/string_manager.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _phoneFormKey = GlobalKey<FormState>();
  Widget _buildIntroTexts(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What is your phone number?",
          style: TextStyle(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: height * 0.03,
        ),
        Container(
            //margin: EdgeInsets.symmetric(horizontal: 2),
            child: Text(
          "Please enter your phone number to verify your account. A verification code will be sent to you.",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
          ),
        )),
      ],
    );
  }

  Widget _buildnextButton(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          onPressed: () {
            // TODO : Navigate to next screen
            Navigator.pushNamed(context, OtpScreenRoute);
          },
          child: Text(
            "Next",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
              primary: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              minimumSize: Size(100, 50)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Form(
        key: _phoneFormKey,
        child: Container(
          margin: EdgeInsets.only(
              left: width * 0.08, right: width * 0.08, top: height * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIntroTexts(context),
              SizedBox(height: height * 0.125),
              PhoneFormField(),
              SizedBox(height: height * 0.07),
              _buildnextButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
