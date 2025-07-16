import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ui/Views/Common/app_style.dart';
import 'package:new_ui/Views/Common/badge.dart';
import 'package:new_ui/Views/Common/height_spacer.dart';
import 'package:new_ui/Views/Common/reusable_text.dart';
import 'package:new_ui/Views/Common/startbuttton.dart';
import 'package:new_ui/Views/Common/togglebutton.dart';
import 'package:new_ui/Views/Common/width_spacer.dart';
import 'package:provider/provider.dart';

// ChangeNotifier to manage toggle state
class ToggleController extends ChangeNotifier {
  bool _isLocationVisible = true;
  bool get isLocationVisible => _isLocationVisible;

  void toggleLocationVisibility() {
    _isLocationVisible = !_isLocationVisible;
    notifyListeners();
  }
}

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return ChangeNotifierProvider<ToggleController>(
      create: (_) => ToggleController(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Stack(
            children: [
              // Background Image (covers the whole screen)
              Positioned.fill(
                child: Image.asset("assets/Map.png", fit: BoxFit.cover),
              ),

              // Padding for the top controls
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 30.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PowerButton(),
                    WidthSpacer(width: 90.w),
                    const RedFillOverlay(),
                  ],
                ),
              ),

              // Bottom Panels
              // Inside Align(alignment: Alignment.bottomCenter, child: ...)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  color:
                      Theme.of(context)
                          .appBarTheme
                          .backgroundColor, // Background color extends here
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      top: 16.h,
                      bottom: 24.h,
                      left: 8.w,
                      right: 8.w,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Consumer<ToggleController>(
                          builder: (context, toggle, child) {
                            return toggle.isLocationVisible
                                ? Container(
                                  width: screenWidth,
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(
                                          context,
                                        ).appBarTheme.backgroundColor,
                                    borderRadius: BorderRadius.circular(15.r),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ReusableText(
                                        text: "Current Vehicle Location",
                                        style: appstyle(
                                          13.h,
                                          Theme.of(context).shadowColor,
                                          FontWeight.normal,
                                        ),
                                      ),
                                      HeightSpacer(size: 6.h),
                                      ReusableText(
                                        text: "Dubai, UAE",
                                        style: appstyle(
                                          14.h,
                                          Theme.of(context).shadowColor,
                                          FontWeight.bold,
                                        ),
                                      ),
                                      HeightSpacer(size: 10.h),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                        child: Image.asset(
                                          "assets/Location.png",
                                          height: 150.h,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                : const SizedBox.shrink();
                          },
                        ),
                        HeightSpacer(size: 10.h),

                        // Auto Adjust Panel
                        // (No changes here; background will appear behind this panel)
                        Container(
                          width: screenWidth,
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).appBarTheme.backgroundColor,
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReusableText(
                                      text: "Auto adjust to region",
                                      style: appstyle(
                                        14.h,
                                        Theme.of(context).shadowColor,
                                        FontWeight.bold,
                                      ),
                                    ),
                                    HeightSpacer(size: 4.h),
                                    ReusableText(
                                      text:
                                          "Enable to automatically select region",
                                      style: appstyle(
                                        10.h,
                                        Theme.of(context).shadowColor,
                                        FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Consumer<ToggleController>(
                                builder: (context, toggle, child) {
                                  return WhiteToggleButton(
                                    onChanged:
                                        (value) =>
                                            toggle.toggleLocationVisibility(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        // Other panels follow here...
                        HeightSpacer(size: 10.h),

                        // Compliance Panel, etc.

                        // Compliance Panel
                        Container(
                          width: screenWidth,
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).appBarTheme.backgroundColor,
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                text: "Compliance status",
                                style: appstyle(
                                  14.h,
                                  Theme.of(context).shadowColor,
                                  FontWeight.bold,
                                ),
                              ),
                              HeightSpacer(size: 4.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 18.sp,
                                  ),
                                  WidthSpacer(width: 6.w),
                                  ReusableText(
                                    text: "Compliance with local regulations",
                                    style: appstyle(
                                      11.h,
                                      Colors.green,
                                      FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        HeightSpacer(size: isPortrait ? 40.h : 16.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
