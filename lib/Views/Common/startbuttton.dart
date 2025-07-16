import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ui/Controllers/powerbutton.dart';
import 'package:provider/provider.dart';

class PowerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PowerButtonProvider>(
      builder: (context, provider, child) {
        return IconButton(
          icon: Container(
            height: 30.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  provider.isOn
                      ? Colors.yellow[300]
                      : Colors.green, // toggled color
              border: Border.all(
                color: Theme.of(context).disabledColor,
                width: 3,
              ),
            ),
            padding: const EdgeInsets.all(2),
            child: Icon(
              Icons.power_settings_new_outlined,
              color: Theme.of(context).scaffoldBackgroundColor,
              size: 25.sp,
            ),
          ),
          onPressed: () {
            provider.togglePower();
          },
        );
      },
    );
  }
}
