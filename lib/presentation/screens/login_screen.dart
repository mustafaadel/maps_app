import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maps_app/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:maps_app/presentation/widgets/phone_form_field.dart';

import '../../constants/string_manager.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneFormKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode;

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

  Future<void> _register(BuildContext context) async {
    if (_phoneFormKey.currentState!.validate()) {
      Navigator.pop(context);
      _phoneFormKey.currentState!.save();
      final phoneAuthCubit = context.read<PhoneAuthCubit>();
      phoneAuthCubit.submitPhoneNumber(countryCode!.dialCode + controller.text);
    } else {
      Navigator.pop(context);
      return;
    }
    final phoneAuthCubit = context.read<PhoneAuthCubit>();
    phoneAuthCubit.submitPhoneNumber(countryCode!.dialCode + controller.text);
  }

  Widget _buildnextButton(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          onPressed: () {
            // TODO : Navigate to next screen
            showProgressIndicator(context);
            _register(context);
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              minimumSize: Size(100, 50)),
          child: Text(
            "Next",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }

  void showProgressIndicator(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.black),
          ),
        );
      },
    );
  }

  Widget _buildPhoneNumberSubmittedBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current; // lma el state byt8ayar
      },
      listener: (context, state) {
        if (state is PhoneAuthLoading) {
          showProgressIndicator(context);
        }
        if (state is PhoneNumberSubmitted) {
          print("submitted");
          Navigator.pop(context);
          Navigator.pushNamed(context, OtpScreenRoute,
              arguments: countryCode!.dialCode + controller.text);
        }
        if (state is PhoneAuthFailure) {
          Navigator.pop(context);
          Navigator.pushNamed(context, OtpScreenRoute,
              arguments: countryCode!.dialCode + controller.text);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      child: Container(),
    );
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
              PhoneFormField(
                countryCode: countryCode,
                controller: controller,
                onTap: () async {
                  // TODO : Show country code picker
                  final code = await countryPicker.showPicker(context: context);
                  countryCode = code;
                },
              ),
              SizedBox(height: height * 0.07),
              _buildnextButton(context),
              _buildPhoneNumberSubmittedBloc(),
            ],
          ),
        ),
      ),
    );
  }
}
