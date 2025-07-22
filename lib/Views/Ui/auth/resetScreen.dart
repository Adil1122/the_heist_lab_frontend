import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ui/Constants/app_constants.dart';
import 'package:new_ui/Controllers/loginprovider.dart';
import 'package:new_ui/Views/Common/app_style.dart';
import 'package:new_ui/Views/Common/custom_btn.dart';
import 'package:new_ui/Views/Common/height_spacer.dart';
import 'package:new_ui/Views/Common/reusable_text.dart';
import 'package:new_ui/Views/Common/textfiled.dart';
import 'package:new_ui/Views/Common/width_spacer.dart';
import 'package:new_ui/Views/Ui/Home/home_page.dart';
//import 'package:new_ui/Views/Ui/Home/home_page.dart';
import 'package:new_ui/Views/Ui/auth/forgotScreen.dart';
import 'package:new_ui/Views/Ui/auth/login_screen.dart';
import 'package:new_ui/Views/Ui/auth/signup.dart';
import 'package:provider/provider.dart';
import '../../../Services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({super.key});

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  //final TextEditingController emailController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

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
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(
      builder: (context, loginNotifier, child) {
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
                                text: "Reset your password",
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
                                    text: "Old Password",
                                    style: appstyle(
                                      12.h,
                                      kDarkGrey,

                                      FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              CustomTextField(
                                controller: oldPasswordController,
                                keyboard: TextInputType.text,
                                obsecuretext: loginNotifier.obsecureText,
                                hinttext: "Old Password",
                                validator: (password) {
                                  if (password!.isEmpty ||
                                      password.length < 7) {
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
                                children: [
                                  WidthSpacer(width: 15.sp),
                                  ReusableText(
                                    text: "New Password",
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
                                hinttext: "New Password",
                                validator: (password) {
                                  if (password!.isEmpty ||
                                      password.length < 7) {
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
                                children: [
                                  WidthSpacer(width: 15.sp),
                                  ReusableText(
                                    text: "Password Retype",
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
                                obsecuretext: loginNotifier.obsecureText,
                                hinttext: "Retype Password",
                                validator: (password) {
                                  if (password!.isEmpty ||
                                      password.length < 7) {
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

                              CustomButton(
                                text: "Reset Password",

                                /*onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                  );
                                },*/
                                onTap: () async {
                                  String old_password =
                                      oldPasswordController.text;
                                  String password = passwordController.text;
                                  String password_confirmation =
                                      passwordConfirmationController.text;

                                  //SnackBar(content: Text('Login started'));

                                  //if (email != '' && password != '') {
                                  int resp = await AuthService.resetPassword(
                                    old_password,
                                    password,
                                    password_confirmation,
                                  );
                                  if (resp == 1) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
                                      ),
                                    );
                                  } else if (resp == 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Invalid old password.'),
                                      ),
                                    );
                                  } else if (resp == 2) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Password confirmation missmatched.',
                                        ),
                                      ),
                                    );
                                  } else if (resp == 3) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('User not found.'),
                                      ),
                                    );
                                  }
                                  //}
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
        );
      },
    );
  }
}
