import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ui/Constants/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:new_ui/Controllers/percentagemodel.dart';

class RedFillOverlay extends StatelessWidget {
  const RedFillOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final percentage = context.watch<PercentageProvider>().percentage;

    return Container(
      width: 60.w,
      height: 20.h,
      decoration: BoxDecoration(
        border: Border.all(color: kLight),
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: (60.w * (percentage / 100)).clamp(0, 60.w),
              height: 20.h,
              decoration: BoxDecoration(
                color: Color.lerp(kOrange, kOrange, percentage / 100),
              ),
            ),
            Center(
              child: Text(
                "${percentage.round()}%",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: kLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
