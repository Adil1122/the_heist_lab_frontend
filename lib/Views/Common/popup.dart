import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ui/Constants/app_constants.dart';
import 'package:new_ui/Controllers/homeContainerprovider.dart';
import 'package:new_ui/Views/Common/app_style.dart';
import 'package:new_ui/Views/Common/custom_btn.dart';
import 'package:new_ui/Views/Common/customsplitter.dart';
import 'package:new_ui/Views/Common/height_spacer.dart';
import 'package:new_ui/Views/Common/reusable_text.dart';
import 'package:provider/provider.dart';

void showTintPresetDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: "Preset Name",
                    style: appstyle(14, kDarkGrey, FontWeight.normal),
                  ),
                  HeightSpacer(size: 10.h),
                  TextField(
                    style: TextStyle(color: kLight),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black,

                      // Border when the TextField is enabled but not focused
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.black, // <-- your desired border color
                          width: 1.5,
                        ),
                      ),

                      // Border when the TextField is focused
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.black, // <-- your focus color
                          width: 2,
                        ),
                      ),

                      // Optional: Border for error state
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  Consumer<ContainerControllerState>(
                    builder: (context, provider, child) {
                      return CustomSplitSlider(
                        value: provider.sliderValue,
                        onChanged: provider.setSliderValue,
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lighter',
                        style: TextStyle(color: Theme.of(context).shadowColor),
                      ),
                      Text(
                        'Darker',
                        style: TextStyle(color: Theme.of(context).shadowColor),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(child: CustomButton(text: "Save", width: 100.w)),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
