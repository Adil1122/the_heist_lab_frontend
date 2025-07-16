import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ui/Constants/app_constants.dart';
import 'package:new_ui/Views/Common/app_style.dart';
import 'package:new_ui/Views/Common/height_spacer.dart';
import 'package:new_ui/Views/Common/reusable_text.dart';
import 'package:new_ui/Views/Common/width_spacer.dart';
import 'package:new_ui/Views/Ui/auth/login_screen.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the next screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kDark.value),
      body: SingleChildScrollView(
        // Allow scrolling
        child: Column(
          children: [
            HeightSpacer(size: 74.h),
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
                WidthSpacer(width: 12.w),
                ReusableText(
                  text: "LABS",
                  style: appstyle(40.h, kLight, FontWeight.bold),
                ),
              ],
            ),
            HeightSpacer(size: 140.h),
            // Use a Container to ensure the image is responsive
            Container(
              width: MediaQuery.of(context).size.width, // Full width
              child: Image.asset('assets/imagecar.png', fit: BoxFit.fill),
            ),
          ],
        ),
      ),
    );
  }
}
