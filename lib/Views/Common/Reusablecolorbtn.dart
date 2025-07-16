import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ui/Constants/app_constants.dart';

class RectangleButton extends StatelessWidget {
  final String text;
  final Color? initialColor;
  final Color? clickedColor;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final IconData? endIcon; // Add this parameter for the end icon
  final bool isSelected;

  const RectangleButton({
    Key? key,
    required this.text,
    this.initialColor,
    this.clickedColor,
    this.onPressed,
    this.width,
    this.height,
    this.endIcon, // Include endIcon in the constructor
    required this.isSelected,
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
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
            child: Container(
              height: height ?? 35.h,
              width: width ?? 55.h,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Distribute space
                children: [
                  Expanded(
                    // Use Expanded to take available space
                    child: Text(
                      text,
                      textAlign: TextAlign.center, // Center the text
                      style: TextStyle(
                        fontSize: 11.h,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  if (endIcon != null) // Check if endIcon is provided
                    SizedBox(width: 4.0), // Space between text and icon
                  if (endIcon != null) // Display the icon if provided
                    Icon(
                      endIcon,
                      size: 16.h, // Set icon size
                      color:
                          Theme.of(
                            context,
                          ).scaffoldBackgroundColor, // Use theme color for icon
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
