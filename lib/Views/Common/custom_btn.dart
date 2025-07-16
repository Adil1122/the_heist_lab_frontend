import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ui/Constants/app_constants.dart';
import 'package:new_ui/Views/Common/app_style.dart';
import 'package:new_ui/Views/Common/reusable_text.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.text,
    this.color,
    this.onTap,
    this.width,
  });
  final String text;
  final Color? color;
  final width;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Container(
          color: kOrange,
          width: width,
          height: hieght * 0.040.h,
          child: Center(
            child: ReusableText(
              text: text,
              style: appstyle(11.h, color ?? kLight, FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
