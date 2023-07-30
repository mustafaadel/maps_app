import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maps_app/constants/color_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  final _otpFormKey = GlobalKey<FormState>();

  String currentText = "";

  String? phoneNumber;

  String? pinCode;


  Widget _buildIntroTexts(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Verify your phone number",
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
          child: RichText(
            text: TextSpan(
              text: "Please enter the 4-digit code sent to you at ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
              ),
              children: [
                TextSpan(
                  text: '$phoneNumber',
                  style: TextStyle(
                    color: MyColors.blue,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPinCode(BuildContext context) {
    return Form(
      key: _otpFormKey,
      child: PinCodeTextField(
        appContext: context,
        autoDismissKeyboard: false,
        obscureText: false,
        length: 6,
        autoFocus: true,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        obscuringCharacter: "*",
        animationType: AnimationType.fade,
        validator: (value) {
          value!.length != 4 ? 'Please enter a valid code' : null;
        },
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(6),
          activeFillColor: MyColors.blue,
          selectedColor: MyColors.blue,
          inactiveColor: MyColors.lightGrey,
          inactiveFillColor: MyColors.lightGrey,
          selectedFillColor: MyColors.lightGrey,
          disabledColor: MyColors.lightGrey,
          activeColor: MyColors.blue,
          borderWidth: 1,
          fieldHeight: 60,
          fieldWidth: 50,
          //activeColor: hasError ? Colors.orange : Colors.white,
        ),
        cursorColor: Colors.black,
        animationDuration: const Duration(milliseconds: 300),
        textStyle: TextStyle(fontSize: 18.sp, height: 1.5),
        //backgroundColor: MyColors.lightGrey,
        keyboardType: TextInputType.number,
        boxShadows: const [
          BoxShadow(
            offset: Offset(0, 1),
            color: Colors.black12,
            blurRadius: 10,
          )
        ],
        onCompleted: (v) {
          // print("Completed");
          //FocusScope.of(context).unfocus();
          pinCode = v;
        },
        onChanged: (value) {
          // print(value);
        },
      ),
    );
  }

  Widget _buildVerificationButton() {
    return Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          onPressed: () {
            // TODO : Navigate to next screen
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              minimumSize: const Size(100, 50)),
          child: Text(
            "Verify",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(
            left: width * 0.08, right: width * 0.08, top: height * 0.1),
        child: Column(
          children: [
            _buildIntroTexts(context),
            SizedBox(height: height * 0.125),
            _buildPinCode(context),
            SizedBox(height: height * 0.07),
            _buildVerificationButton(),
          ],
        ),
      ),
    );
  }
}
