import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ui/Constants/app_constants.dart';
import 'package:new_ui/Controllers/homeContainerprovider.dart';
import 'package:provider/provider.dart';

class WhiteToggleButton extends StatelessWidget {
  final String onText;
  final String offText;
  final double width;
  final double height;
  final ValueChanged<bool>? onChanged;

  const WhiteToggleButton({
    Key? key,
    this.onText = 'ON',
    this.offText = 'OFF',
    this.width = 60,
    this.height = 30,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isOn = context.select<ContainerControllerState, bool>(
      (provider) => provider.manualMode,
    );

    final themeColor = isOn ? kOrange : kLight;
    final thumbColor = isOn ? kLight : kDarkGrey;

    return GestureDetector(
      onTap: () {
        final provider = Provider.of<ContainerControllerState>(
          context,
          listen: false,
        );
        provider.toggleManualMode();
        if (onChanged != null) {
          onChanged!(provider.manualMode);
        }
      },
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          color: themeColor,
          borderRadius: BorderRadius.circular(height.h / 2),
          border: Border.all(
            color: isOn ? Color(kOrange.value) : Color(kDarkGrey.value),
            width: 2.w,
          ),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 9, spreadRadius: 2),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Text labels
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [],
            ),
            // Thumb
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
              curve: Curves.easeInOut,
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Container(
                  width: (height.h - 20.w), // Ensures it fits inside toggle
                  height: (height.h - 14.w),
                  decoration: BoxDecoration(
                    color: thumbColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
