import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ui/Constants/app_constants.dart';
import 'package:new_ui/Views/Common/app_style.dart';
import 'package:new_ui/Views/Common/custom_btn.dart';
import 'package:new_ui/Views/Common/height_spacer.dart';
import 'package:new_ui/Views/Common/reusable_text.dart';
import 'package:new_ui/Views/Common/textfiled.dart';
import 'package:new_ui/Views/Common/width_spacer.dart';
import 'package:new_ui/Views/Ui/auth/signup.dart';

class forgot_Screen extends StatefulWidget {
  const forgot_Screen({super.key});

  @override
  State<forgot_Screen> createState() => _forgot_ScreenState();
}

class _forgot_ScreenState extends State<forgot_Screen> {
  final TextEditingController emailController = TextEditingController();

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
                  text: "Recover Password",
                  style: appstyle(16, kLight, FontWeight.bold),
                ),
                HeightSpacer(size: 5.h),
                ReusableText(
                  text: "Enter email to cover your account",
                  style: appstyle(12.h, kDarkGrey, FontWeight.normal),
                ),
                HeightSpacer(size: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    WidthSpacer(width: 7.h),
                    ReusableText(
                      text: "Email",
                      style: appstyle(12.h, kDarkGrey, FontWeight.normal),
                    ),
                  ],
                ),
                CustomTextField(
                  controller: emailController,
                  hinttext: "You@example.com",
                  validator: (email) {
                    if (email!.isEmpty || !email.contains("@")) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                  keyboard: TextInputType.emailAddress,
                ),

                CustomButton(text: "Send recovery email"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ReusableText(
                      text: "Enter email to re-cover your account. ",
                      style: appstyle(11.h, kDarkGrey, FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      },
                      child: ReusableText(
                        text: "Sign up",
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
