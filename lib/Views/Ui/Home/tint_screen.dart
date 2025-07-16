import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ui/Views/Common/badge.dart';
import 'package:new_ui/Views/Common/startbuttton.dart';
import 'package:provider/provider.dart';
import 'package:new_ui/Controllers/tintscreenprovider.dart'; // <-- Make sure this is imported
import 'package:new_ui/Views/Common/Reusablecolorbtn.dart';
import 'package:new_ui/Views/Common/app_style.dart';
import 'package:new_ui/Views/Common/container_slider.dart';
import 'package:new_ui/Views/Common/height_spacer.dart';
import 'package:new_ui/Views/Common/popup.dart';
import 'package:new_ui/Views/Common/reusable_text.dart';
import 'package:new_ui/Views/Common/togglebutton.dart';
import 'package:new_ui/Views/Common/width_spacer.dart';

class TintScreen extends StatelessWidget {
  const TintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                // Background Image
                Positioned.fill(
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/Carinside.png",
                        fit: BoxFit.fill,

                        alignment: Alignment.topCenter,
                      ),
                      Positioned(
                        right: 25,
                        top: 131,
                        child: Image.asset(
                          "assets/tintglass.png",
                          color: Colors.transparent,
                          height: 155.h,
                          width: 330,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ],
                  ),
                ),
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
                      // Placeholder for balance
                    ],
                  ),
                ),
                // 🔥 Overlay at top of the screen (PowerButton, RedFillOverlay, etc.)

                // Foreground Content at Bottom
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ControllerWidget(
                          title: "Tint Slider",
                          initialSliderValue: 0,
                          showToggle: false,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.0.w,
                            vertical: isPortrait ? 8.h : 16.h,
                          ),
                          child: Consumer<TintProvider>(
                            builder: (context, pr, _) {
                              final selected = pr.selectedOption;
                              return Column(
                                children: [
                                  // Tint Presets
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8.0),
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
                                          CrossAxisAlignment.start,
                                      children: [
                                        ReusableText(
                                          text: "Tinting Presets",
                                          style: appstyle(
                                            14.sp,
                                            Theme.of(context).shadowColor,
                                            FontWeight.bold,
                                          ),
                                        ),
                                        HeightSpacer(size: 4.h),
                                        ReusableText(
                                          text:
                                              "Select premade presets or create custom tint",
                                          style: appstyle(
                                            10.sp,
                                            Theme.of(context).shadowColor,
                                            FontWeight.normal,
                                          ),
                                        ),
                                        HeightSpacer(size: 8.h),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              RectangleButton(
                                                text: "Light",
                                                isSelected:
                                                    selected ==
                                                    TintOption.light,
                                                onPressed:
                                                    () => pr.selectOption(
                                                      TintOption.light,
                                                    ),
                                              ),
                                              WidthSpacer(width: 8.w),
                                              RectangleButton(
                                                text: "Medium",
                                                isSelected:
                                                    selected ==
                                                    TintOption.medium,
                                                onPressed:
                                                    () => pr.selectOption(
                                                      TintOption.medium,
                                                    ),
                                              ),
                                              WidthSpacer(width: 8.w),
                                              RectangleButton(
                                                text: "Dark",
                                                isSelected:
                                                    selected == TintOption.dark,
                                                onPressed:
                                                    () => pr.selectOption(
                                                      TintOption.dark,
                                                    ),
                                              ),
                                              WidthSpacer(width: 10.w),
                                              GestureDetector(
                                                onTap: () {
                                                  showTintPresetDialog(context);
                                                },
                                                child: Container(
                                                  height: 40.h,
                                                  width: 40.h,
                                                  decoration: BoxDecoration(
                                                    color: const Color(
                                                      0XFF999999,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          7.r,
                                                        ),
                                                  ),
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  HeightSpacer(size: 8.h),

                                  // Auto Tint Toggle
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10.0),
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ReusableText(
                                                text: "Tinting Presets",
                                                style: appstyle(
                                                  14.sp,
                                                  Theme.of(context).shadowColor,
                                                  FontWeight.bold,
                                                ),
                                              ),
                                              HeightSpacer(size: 4.h),
                                              ReusableText(
                                                text:
                                                    "Enable light sensor automatic tinting",
                                                style: appstyle(
                                                  8.sp,
                                                  Theme.of(context).shadowColor,
                                                  FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        WhiteToggleButton(),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        HeightSpacer(size: 50.h),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
