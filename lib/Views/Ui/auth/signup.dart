import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ui/Constants/app_constants.dart';
import 'package:new_ui/Controllers/signupprovider.dart';
import 'package:new_ui/Views/Common/app_style.dart';
import 'package:new_ui/Views/Common/custom_btn.dart';
import 'package:new_ui/Views/Common/height_spacer.dart';
import 'package:new_ui/Views/Common/reusable_text.dart';
import 'package:new_ui/Views/Common/textfiled.dart';
import 'package:new_ui/Views/Common/width_spacer.dart';
import 'package:new_ui/Views/Ui/Home/home_page.dart';
import 'package:new_ui/Views/Ui/auth/activateOtpScreen.dart';
import 'package:new_ui/Views/Ui/auth/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Services/auth_service.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print('token: $token');

    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }

  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Signupprovider>(
      builder: (context, signupprovider, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Column(
              children: [
                // Top image with flex 1
                Flexible(
                  flex: 1,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Image.asset(
                        'assets/imagecar.png',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      // Text on top of the image
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 40.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                    style: appstyle(
                                      40.h,
                                      kOrange,
                                      FontWeight.bold,
                                    ),
                                  ),
                                  WidthSpacer(width: 12.h),
                                  ReusableText(
                                    text: "LABS",
                                    style: appstyle(
                                      40.h,
                                      kLight,

                                      FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              HeightSpacer(size: 30.h),
                              Row(
                                children: [
                                  WidthSpacer(width: 15.sp),
                                  ReusableText(
                                    text: "Name",
                                    style: appstyle(
                                      12.h,
                                      kDarkGrey,

                                      FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              CustomTextField(
                                controller: namecontroller,
                                hinttext: "Name",
                                validator: (name) {
                                  if (name!.isEmpty) {
                                    return "Enter a Name";
                                  }
                                  return null;
                                },
                                keyboard: TextInputType.name,
                              ),
                              Row(
                                children: [
                                  WidthSpacer(width: 15.sp),
                                  ReusableText(
                                    text: "Email",
                                    style: appstyle(
                                      12.h,
                                      kDarkGrey,

                                      FontWeight.w500,
                                    ),
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
                              Row(
                                children: [
                                  WidthSpacer(width: 15.sp),
                                  ReusableText(
                                    text: "Password",
                                    style: appstyle(
                                      12.h,
                                      kDarkGrey,

                                      FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              CustomTextField(
                                controller: passwordController,
                                keyboard: TextInputType.text,
                                obsecuretext: signupprovider.obsecureText,
                                hinttext: "Password",
                                validator: (password) {
                                  if (password!.isEmpty ||
                                      password.length < 7) {
                                    return "Enter a valid password";
                                  }
                                  return null;
                                },

                                suffixicon: GestureDetector(
                                  onTap: () {
                                    signupprovider.obsecureText =
                                        !signupprovider.obsecureText;
                                  },
                                  child: Icon(
                                    signupprovider.obsecureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: kDarkGrey,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  WidthSpacer(width: 15.sp),
                                  ReusableText(
                                    text: "Rewrite Password",
                                    style: appstyle(
                                      12.h,
                                      kDarkGrey,

                                      FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              CustomTextField(
                                controller: passwordConfirmationController,
                                keyboard: TextInputType.text,
                                obsecuretext: signupprovider.obsecureText,
                                hinttext: "Password",
                                validator: (password) {
                                  if (password!.isEmpty ||
                                      password.length < 7) {
                                    return "Enter a valid password";
                                  }
                                  return null;
                                },

                                suffixicon: GestureDetector(
                                  onTap: () {
                                    signupprovider.obsecureText =
                                        !signupprovider.obsecureText;
                                  },
                                  child: Icon(
                                    signupprovider.obsecureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: kDarkGrey,
                                  ),
                                ),
                              ),
                              HeightSpacer(size: 10.h),
                              CustomButton(
                                text: "Sign up",

                                onTap: () async {
                                  String name = namecontroller.text;
                                  String email = emailController.text;
                                  String password = passwordController.text;
                                  String password_confirmation = passwordConfirmationController.text;

                                  bool isSuccess = await AuthService.registerUser(name, email, password, password_confirmation);
                                  if (isSuccess) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ActivateOtpScreen(),
                                      ),
                                    );
                                    /*ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Register success')),
                                    );*/
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Register failed')),
                                    );
                                  }
                                }

                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ReusableText(
                                    text: "Already have an account? ",
                                    style: appstyle(
                                      12.h,
                                      kDarkGrey,
                                      FontWeight.w500,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginPage(),
                                        ),
                                      );
                                    },
                                    child: ReusableText(
                                      text: "Sign In",
                                      style: appstyle(
                                        12.h,
                                        kOrange,
                                        FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
