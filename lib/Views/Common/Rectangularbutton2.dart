import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ui/Constants/app_constants.dart';

class RectangleButton2 extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // Callback for button press
  final IconData? endIcon;
  final double? width;
  final double? height;
  final double? iconSize;
  final Color? initialColor;
  final Color? clickedColor;
  final Color? iconColor;
  final bool isSelected; // Renamed for clarity

  const RectangleButton2({
    Key? key,
    required this.text,
    this.onPressed,
    this.endIcon,
    this.width,
    this.height,
    this.iconSize,
    this.iconColor,
    required this.isSelected, // Renamed parameter
    this.initialColor,
    this.clickedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        isSelected
            ? (clickedColor ?? kOrange)
            : (initialColor ?? Theme.of(context).disabledColor);

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: onPressed, // Attach the onPressed callback here
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
            child: Container(
              height: height ?? 35.h,
              width: width ?? 55.h,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: iconColor ?? Theme.of(context).shadowColor,
                      fontSize: 11.h,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
                    ),
                  ),
                  if (endIcon != null) ...[
                    SizedBox(width: 4.0),
                    Icon(
                      endIcon,
                      size: iconSize ?? 16.h,
                      color: iconColor ?? Theme.of(context).shadowColor,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
