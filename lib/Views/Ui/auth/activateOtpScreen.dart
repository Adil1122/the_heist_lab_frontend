import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ui/Constants/app_constants.dart';
import 'package:new_ui/Services/auth_service.dart';
import 'package:new_ui/Views/Common/app_style.dart';
import 'package:new_ui/Views/Common/custom_btn.dart';
import 'package:new_ui/Views/Common/height_spacer.dart';
import 'package:new_ui/Views/Common/reusable_text.dart';
import 'package:new_ui/Views/Common/textfiled.dart';
import 'package:new_ui/Views/Common/width_spacer.dart';
import 'package:new_ui/Views/Ui/auth/forgotScreen.dart';
import 'package:new_ui/Views/Ui/auth/login_screen.dart';
import 'package:new_ui/Views/Ui/auth/signup.dart';

class ActivateOtpScreen extends StatefulWidget {
  const ActivateOtpScreen({super.key});

  @override
  State<ActivateOtpScreen> createState() => _ActivateOtpScreenState();
}

class _ActivateOtpScreenState extends State<ActivateOtpScreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDark,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ReusableText(
                  text: "THE",
                  style: appstyle(40.h, kLight, FontWeight.bold),
                ),
                // Row for "HEIST" and "LABS" side by side with spacing
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReusableText(
                      text: "HEIST",
                      style: appstyle(40.h, kOrange, FontWeight.bold),
                    ),
                    WidthSpacer(width: 12.sp),
                    ReusableText(
                      text: "LABS",
                      style: appstyle(40.h, kLight, FontWeight.bold),
                    ),
                  ],
                ),
                HeightSpacer(size: 30.h),
                Center(child: Image.asset("assets/Group.png")),
                HeightSpacer(size: 20.h),
                ReusableText(
                  text: "Activate OTP Screen",
                  style: appstyle(16, kLight, FontWeight.bold),
                ),
                HeightSpacer(size: 5.h),
                ReusableText(
                  text: "Enter OTP to activate your account",
                  style: appstyle(12.h, kDarkGrey, FontWeight.normal),
                ),
                HeightSpacer(size: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    WidthSpacer(width: 7.h),
                    ReusableText(
                      text: "OTP",
                      style: appstyle(12.h, kDarkGrey, FontWeight.normal),
                    ),
                  ],
                ),
                CustomTextField(
                  controller: otpController,
                  hinttext: "Enter OTP to activate",
                  validator: (otp) {
                    if (otp!.isEmpty) {
                      return "Enter a valid otp";
                    }
                    return null;
                  },
                  keyboard: TextInputType.number,
                ),

                CustomButton(
                  text: "Enter OTP",

                  onTap: () async {
                    String otp = otpController.text;

                    int resp = await AuthService.activateUser(otp);
                    if (resp == 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    } else if (resp == 0) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('OTP expired.')));
                    } else if (resp == 2) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('User not found.')),
                      );
                    } else if (resp == 3) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('OTP Mismatched.')),
                      );
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReusableText(
                      text: "Go Back to Login. ",
                      style: appstyle(11.h, kDarkGrey, FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: ReusableText(
                        text: "Login",
                        style: appstyle(11.h, kOrange, FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
