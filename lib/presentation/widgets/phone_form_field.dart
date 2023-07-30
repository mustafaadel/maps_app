import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maps_app/constants/color_manager.dart';
import 'package:maps_app/presentation/screens/login_screen.dart';

class PhoneFormField extends StatelessWidget {
  static String? phoneNumber;
  CountryCode? countryCode;
  final TextEditingController controller;
  final VoidCallback onTap;

  PhoneFormField({
    Key? key,
    required this.countryCode,
    required this.controller,
    required this.onTap,
  }) : super(key: key);

  String generateCountryFlag(String cCode) {
    String countryCode = cCode;
    String flag = countryCode
        .toUpperCase()
        .codeUnits
        .map((e) => String.fromCharCode(e + 127397))
        .join();
    return flag;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: height * 0.015),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: MyColors.lightGrey),
            ),
            child: GestureDetector(
              onTap: onTap,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 8.0),
                    child: countryCode != null
                        ? Text(
                            generateCountryFlag(countryCode!.code),
                            style: TextStyle(fontSize: 18.sp),
                          )
                        : Text(
                            generateCountryFlag('eg'),
                            style: TextStyle(fontSize: 18.sp),
                          ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: countryCode != null
                        ? Text(countryCode!.dialCode,
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.sp))
                        : Text('+20',
                            style: TextStyle(
                                color: Colors.black, fontSize: 16.sp)),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          flex: 2,
          child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: MyColors.blue),
              ),
              child: TextFormField(
                autofocus: true,
                //focusNode: FocusNode(),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                controller: controller,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  letterSpacing: 1.5,
                ),
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.sp,
                    letterSpacing: 1,
                  ),
                  border: InputBorder.none,
                ),
                cursorColor: Colors.black,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  } else if (value.length < 10) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  phoneNumber = newValue;
                },
                onChanged: (value) {
                  phoneNumber = value;
                },
              )),
        )
      ],
    );
  }
}
