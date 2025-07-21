import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ui/Constants/app_constants.dart';
import 'package:new_ui/Controllers/Themechanger.dart';
import 'package:new_ui/Controllers/settingsprovider.dart';
import 'package:new_ui/Views/Common/Rectangularbutton2.dart';
import 'package:new_ui/Views/Common/app_style.dart';
import 'package:new_ui/Views/Common/badge.dart';
import 'package:new_ui/Views/Common/height_spacer.dart';
import 'package:new_ui/Views/Common/reusable_text.dart';
import 'package:new_ui/Views/Common/startbuttton.dart';
import 'package:new_ui/Views/Common/width_spacer.dart';
import 'package:new_ui/Views/Ui/auth/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {

  void logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    //await prefs.clear(); // or 
    prefs.remove('auth_token');

    // Redirect to Login screen and remove Home from back stack
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );

  }


  const SettingsScreen({
    super.key,
    this.successfulTintAlerts,
    this.onSystemErrorChanged,
    this.onSuccessfulTintChanged,
    this.systemErrorAlerts,
  });
  final bool? successfulTintAlerts;
  final ValueChanged<bool>? onSystemErrorChanged;
  final ValueChanged<bool>? onSuccessfulTintChanged;
  final bool? systemErrorAlerts;
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    double fontScale(double size) => isPortrait ? size.sp : (size - 1).sp;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 2.0,
                  vertical: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PowerButton(),
                    WidthSpacer(width: 90.w),
                    const RedFillOverlay(),
                    // Placeholder for balance
                  ],
                ),
              ),
              ReusableText(
                text: "Settings",
                style: appstyle(
                  fontScale(15),
                  Theme.of(context).shadowColor,
                  FontWeight.normal,
                ),
              ),

              HeightSpacer(size: 10.h),

              // User Profile Panel
              _buildUserProfilePanel(context, fontScale),

              HeightSpacer(size: 10.h),

              // Notification Panel
              _buildNotificationPanel(context, fontScale),

              HeightSpacer(size: 10.h),

              // Theme Settings
              _buildThemePanel(fontScale, context),

              HeightSpacer(size: 10.h),

              // Accessibility Panel
              _buildAccessibilityPanel(fontScale, context),

              HeightSpacer(size: 10.h),

              // Bottom Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40.h,
                    width: 90.w,
                    decoration: BoxDecoration(
                      color: Theme.of(context).appBarTheme.backgroundColor,
                      border: Border.all(color: kOrange),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          logout(context);
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );*/
                        },
                        child: ReusableText(
                          text: "Sign Out",
                          style: appstyle(10.h, kDarkGrey, FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 35.h,
                    width: 235.w,
                    decoration: BoxDecoration(
                      color: Theme.of(context).appBarTheme.backgroundColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: ReusableText(
                        text: "Edit profile settings",
                        style: appstyle(10.h, kDarkGrey, FontWeight.normal),
                      ),
                    ),
                  ),
                ],
              ),
              HeightSpacer(size: isPortrait ? 40.h : 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfilePanel(
    BuildContext context,
    double Function(double) fs,
  ) {
    return Consumer<SettingsProvider>(
      builder: (context, pr, _) {
        final selected = pr.selectedOption;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor,

            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableText(
                text: "User Profile",
                style: appstyle(fs(13), kDarkGrey, FontWeight.normal),
              ),
              HeightSpacer(size: 6.h),
              RectangleButton2(
                isSelected: selected == tintOption.light,
                onPressed: () => pr.selectOption(tintOption.light),
                text: "Daylight Mode",

                width: double.infinity,
                endIcon: Icons.delete,
              ),
              RectangleButton2(
                isSelected: selected == tintOption.dark,
                onPressed: () => pr.selectOption(tintOption.dark),

                text: "Night Mode",
                width: double.infinity,
                endIcon: Icons.delete,
              ),
              RectangleButton2(
                isSelected: selected == tintOption.medium,
                onPressed: () => pr.selectOption(tintOption.medium),

                text: "Full Privacy",
                width: double.infinity,
                endIcon: Icons.delete,
              ),
              HeightSpacer(size: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _iconTextRow(Icons.edit, () {}, "Edit Profiles", fs, context),
                  _iconTextRow(
                    Icons.add_circle,
                    () {},
                    "Create new",
                    fs,
                    context,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNotificationPanel(
    BuildContext context,
    double Function(double) fs,
  ) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,

        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableText(
                text: "Notification settings",
                style: appstyle(fs(13), kDarkGrey, FontWeight.normal),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  ReusableText(
                    text: "System Error Alerts",
                    style: appstyle(
                      fs(12),
                      Theme.of(context).shadowColor,
                      FontWeight.normal,
                    ),
                  ),
                  Transform.scale(
                    scale: 0.75,
                    child: Switch(
                      value: settingsProvider.systemErrorAlert,
                      onChanged: settingsProvider.toggleSystemErrorAlert,
                      activeColor: Colors.grey,
                      activeTrackColor: Colors.green,
                      inactiveThumbColor: Colors.grey,
                      inactiveTrackColor: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(
                    text: "Successful Tint Error",
                    style: appstyle(
                      fs(12),
                      Theme.of(context).shadowColor,
                      FontWeight.normal,
                    ),
                  ),
                  Transform.scale(
                    scale: 0.75,
                    child: Switch(
                      value: settingsProvider.successfulTintAlert,
                      onChanged: settingsProvider.toggleSuccessfulTintAlert,
                      activeColor: Colors.grey,
                      activeTrackColor: Colors.green,
                      inactiveThumbColor: Colors.grey,
                      inactiveTrackColor: kLight,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildThemePanel(double Function(double) fs, BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReusableText(
            text: "Theme settings",
            style: appstyle(fs(13), kDarkGrey, FontWeight.normal),
          ),
          HeightSpacer(size: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _themeToggle(
                Icons.light_mode,
                "Light",
                () {
                  themeProvider.toggleTheme(false); // Set to light mode
                },
                Colors.black,
                fs,
                Colors.white,
              ),

              WidthSpacer(width: 10.w),
              _themeToggle(
                Icons.dark_mode,
                "Dark",
                () {
                  themeProvider.toggleTheme(true); // Set to dark mode
                },
                Colors.white,
                fs,
                Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAccessibilityPanel(
    double Function(double) fs,
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,

        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReusableText(
            text: "Accessibility options",
            style: appstyle(fs(13), kDarkGrey, FontWeight.normal),
          ),
          HeightSpacer(size: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ReusableText(
                    text: "Font Size:",
                    style: appstyle(
                      fs(12),
                      Theme.of(context).shadowColor,
                      FontWeight.normal,
                    ),
                  ),
                  WidthSpacer(width: 6.w),
                  Container(
                    height: 20.h,
                    width: 100.w,
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor,

                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                            text: "Normal",
                            style: appstyle(
                              fs(10),
                              Theme.of(context).shadowColor,
                              FontWeight.normal,
                            ),
                          ),

                          Icon(
                            Icons.arrow_drop_down,
                            color: Theme.of(context).shadowColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  ReusableText(
                    text: "High Contrast",
                    style: appstyle(
                      fs(12),
                      Theme.of(context).shadowColor,
                      FontWeight.normal,
                    ),
                  ),
                  WidthSpacer(width: 5.w),
                  Icon(Icons.check_box, size: 18.sp),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconTextRow(
    IconData icon,
    final Function()? onTap,
    String text,
    double Function(double) fs,
    BuildContext context,
  ) {
    return GestureDetector(
      onDoubleTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).shadowColor, size: 18.sp),
          WidthSpacer(width: 4.w),
          ReusableText(
            text: text,
            style: appstyle(
              fs(12),
              Theme.of(context).shadowColor,
              FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _themeToggle(
    IconData icon,
    String label,
    VoidCallback? onTap, // Change Function? to VoidCallback?
    Color textColor,
    double Function(double) fs,
    Color continercolor,
  ) {
    return Material(
      color: continercolor,

      // Use isActive to determine color
      borderRadius: BorderRadius.circular(10.r),

      child: InkWell(
        onTap: onTap, // Call the provided callback when tapped
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          height: 42.h,
          width: 150.w,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor),
              WidthSpacer(width: 6.w),
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: fs(11),
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // BoxDecoration _boxDecoration() {
  //   return BoxDecoration(
  //     color: Color(kDark.value),
  //     borderRadius: BorderRadius.circular(15.r),
  //     boxShadow: const [
  //       BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2),
  //     ],
  //   );
  // }
}
