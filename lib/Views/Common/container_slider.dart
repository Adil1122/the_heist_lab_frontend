import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ui/Constants/app_constants.dart';
import 'package:new_ui/Controllers/homeContainerprovider.dart';
import 'package:new_ui/Controllers/percentagemodel.dart';
import 'package:new_ui/Views/Common/app_style.dart';
import 'package:new_ui/Views/Common/customsplitter.dart';
import 'package:new_ui/Views/Common/reusable_text.dart';
import 'package:new_ui/Views/Common/togglebutton.dart';
import 'package:new_ui/Views/Common/width_spacer.dart';
import 'package:provider/provider.dart';

class ControllerWidget extends StatelessWidget {
  final String title;
  final String? manualText;
  final String? autoText;
  final ValueChanged<bool>? onToggleChanged;
  final double initialSliderValue;
  final bool initialManualMode;
  final bool showToggle;
  final ValueChanged<double>? onSliderChanged;

  ControllerWidget({
    Key? key,
    required this.title,
    this.manualText,
    this.autoText,
    this.onToggleChanged,
    required this.initialSliderValue,
    this.initialManualMode = true,
    this.showToggle = true,
    this.onSliderChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final screenHeight = MediaQuery.of(context).size.height;

    final double collapsedHeight =
        isPortrait ? screenHeight / 12 : screenHeight / 3;
    final double expandedHeight =
        isPortrait ? screenHeight / 5 : screenHeight / 2;

    return ChangeNotifierProvider(
      create:
          (context) =>
              ContainerControllerState()
                ..setSliderValue(initialSliderValue)
                ..setManualMode(initialManualMode)
                ..setExpanded(showToggle ? initialManualMode : true),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Consumer<ContainerControllerState>(
          builder: (context, provider, child) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: provider.isExpanded ? expandedHeight : collapsedHeight,
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              padding: EdgeInsets.all(8.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: appstyle(
                          12.h,
                          Theme.of(context).shadowColor,
                          FontWeight.bold,
                        ),
                      ),
                      if (showToggle)
                        Row(
                          children: [
                            Text(
                              provider.manualMode
                                  ? (manualText ?? "Manual Mode")
                                  : (autoText ?? "Auto Mode"),
                              style: appstyle(
                                10.h,
                                Theme.of(context).shadowColor,
                                FontWeight.normal,
                              ),
                            ),
                            WidthSpacer(width: 3.h),
                            WhiteToggleButton(
                              onChanged: (value) {
                                provider.setManualMode(value);
                                provider.setExpanded(value);
                                if (onToggleChanged != null) {
                                  onToggleChanged!(value);
                                }
                              },
                            ),
                          ],
                        ),
                    ],
                  ),

                  // Expandable section
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    child: SizedBox(
                      height:
                          provider.isExpanded
                              ? expandedHeight - collapsedHeight
                              : 0,
                      child:
                          provider.isExpanded
                              ? Column(
                                children: [
                                  CustomSplitSlider(
                                    value: provider.sliderValue,
                                    onChanged: (value) {
                                      provider.setSliderValue(value);
                                      final scaled =
                                          value * 100; // Convert to percentage
                                      context
                                          .read<PercentageProvider>()
                                          .setPercentage(scaled);
                                      if (onSliderChanged != null) {
                                        onSliderChanged!(scaled);
                                      }
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ReusableText(
                                        text: "Lighter",
                                        style: appstyle(
                                          10.h,
                                          kDarkGrey,
                                          FontWeight.normal,
                                        ),
                                      ),
                                      ReusableText(
                                        text: "Darker",
                                        style: appstyle(
                                          10.h,
                                          kDarkGrey,
                                          FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                              : const SizedBox.shrink(), // Use SizedBox.shrink() instead of null
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
