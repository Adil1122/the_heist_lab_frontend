import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ui/Constants/app_constants.dart';
import 'package:new_ui/Controllers/AuthProvider.dart';
import 'package:new_ui/Controllers/loginprovider.dart';
import 'package:new_ui/Views/Common/app_style.dart';
import 'package:new_ui/Views/Common/custom_btn.dart';
import 'package:new_ui/Views/Common/height_spacer.dart';
import 'package:new_ui/Views/Common/reusable_text.dart';
import 'package:new_ui/Views/Common/textfiled.dart';
import 'package:new_ui/Views/Common/width_spacer.dart';
import 'package:new_ui/Views/Ui/Home/home_page.dart';
import 'package:new_ui/Views/Ui/auth/forgotScreen.dart';
import 'package:new_ui/Views/Ui/auth/signup.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final loginNotifier = Provider.of<LoginNotifier>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Form(
          key: _formKey,
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
                                WidthSpacer(width: 12.sp),
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
                            SizedBox(height: 80.sp),
                            ReusableText(
                              text: "WELCOME BACK",
                              style: appstyle(25.h, kLight, FontWeight.bold),
                            ),
                            SizedBox(height: 7.h),
                            ReusableText(
                              text: "Login to control your tint",
                              style: appstyle(
                                13.h,
                                kDarkGrey,
                                FontWeight.normal,
                              ),
                            ),
                            HeightSpacer(size: 30.h),
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
                              obsecuretext: loginNotifier.obsecureText,
                              hinttext: "Password",
                              validator: (password) {
                                if (password!.isEmpty) {
                                  return "Enter a valid password";
                                }
                                return null;
                              },
                              suffixicon: GestureDetector(
                                onTap: () {
                                  loginNotifier.obsecureText =
                                      !loginNotifier.obsecureText;
                                },
                                child: Icon(
                                  loginNotifier.obsecureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: kDarkGrey,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => forgot_Screen(),
                                      ),
                                    );
                                  },
                                  child: ReusableText(
                                    text: "Forgot Password?",
                                    style: appstyle(
                                      12.h,
                                      kDarkGrey,
                                      FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (authProvider.errorMessage != null)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Text(
                                  authProvider.errorMessage!,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            CustomButton(
                              text: "Sign in",

                              onTap:
                                  authProvider.isLoading
                                      ? null
                                      : () async {
                                        if (_formKey.currentState!.validate()) {
                                          final success = await authProvider
                                              .login(
                                                emailController.text,
                                                passwordController.text,
                                              );
                                          if (success == true) {
                                            print(
                                              "Login successful! Navigating to HomePage...",
                                            );
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) => HomePage(),
                                              ),
                                            );
                                          } else {
                                            print("Login failed jgj");
                                          }
                                        }
                                      },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ReusableText(
                                  text: "Don't have an account. ",
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
                                        builder: (context) => Signup(),
                                      ),
                                    );
                                  },
                                  child: ReusableText(
                                    text: "Sign Up",
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
      ),
    );
  }
}
