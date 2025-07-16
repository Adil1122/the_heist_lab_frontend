import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ui/Controllers/percentagemodel.dart';
import 'package:new_ui/Views/Common/animatedcontainer.dart';
import 'package:new_ui/Views/Common/app_style.dart';
import 'package:new_ui/Views/Common/badge.dart';
import 'package:new_ui/Views/Common/container_slider.dart';
import 'package:new_ui/Views/Common/height_spacer.dart';
import 'package:new_ui/Views/Common/reusable_text.dart';
import 'package:new_ui/Views/Common/startbuttton.dart';
import 'package:new_ui/Views/Common/width_spacer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/image3.png",
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                  ],
                ),
              ),

              // 🔥 Add your UI elements on top of the image here
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

                    // Use Positioned to place RedFillOverlay correctly
                    Stack(
                      children: [
                        RedFillOverlay(), // This will be positioned based on its own logic
                        // You can add other elements here if needed
                      ],
                    ),
                  ],
                ),
              ),
              // ✅ overlay that fills with red
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  HeightSpacer(size: 230.h),
                  ControllerWidget(
                    showToggle: true,
                    title: "Tint Slider",
                    initialSliderValue:
                        context.read<PercentageProvider>().percentage,
                    autoText: "Auto Mode",
                    manualText: "Manual Mode",
                    onSliderChanged: (value) {
                      context.read<PercentageProvider>().setPercentage(value);
                    },
                    onToggleChanged: (value) {}, // toggle logic here
                  ),
                  LocationContainer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: Theme.of(context).appBarTheme.backgroundColor,
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
                  ),

                  HeightSpacer(size: 70.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
