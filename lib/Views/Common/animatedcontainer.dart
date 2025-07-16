import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ui/Controllers/homeContainerprovider.dart';
import 'package:new_ui/Views/Common/app_style.dart';
import 'package:provider/provider.dart';

class LocationContainer extends StatelessWidget {
  final String title;
  final String locationText;

  const LocationContainer({
    Key? key,
    this.title = "Your Location",
    this.locationText = "Dubai UAE",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContainerControllerState()..setExpanded(false),
      child: Consumer<ContainerControllerState>(
        builder: (context, provider, _) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header row with title and toggle icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: appstyle(
                            13.h,
                            Theme.of(context).shadowColor,
                            FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap:
                              () => provider.setExpanded(!provider.isExpanded),
                          child: Icon(
                            provider.isExpanded
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                            size: 40.h,
                          ),
                        ),
                      ],
                    ),
                    // Animate expansion/collapse of content
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: ConstrainedBox(
                        constraints:
                            provider.isExpanded
                                ? BoxConstraints()
                                : BoxConstraints(maxHeight: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              locationText,
                              style: appstyle(
                                12.h,
                                Theme.of(context).shadowColor,
                                FontWeight.normal,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Image.asset(
                              "assets/Location.png",
                              fit: BoxFit.cover,
                              width: 350.w,
                              height: 90.h,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      Center(child: Text('Image load error')),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
