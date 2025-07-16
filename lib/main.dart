import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ui/Constants/app_constants.dart';
import 'package:new_ui/Controllers/AuthProvider.dart';
import 'package:new_ui/Controllers/Themechanger.dart';
import 'package:new_ui/Controllers/homeContainerprovider.dart';
import 'package:new_ui/Controllers/loginprovider.dart';
import 'package:new_ui/Controllers/percentagemodel.dart';
import 'package:new_ui/Controllers/powerbutton.dart';
import 'package:new_ui/Controllers/settingsprovider.dart';
import 'package:new_ui/Controllers/signupprovider.dart';
import 'package:new_ui/Controllers/tintscreenprovider.dart';

import 'package:new_ui/Views/Common/Themechanger.dart';
import 'package:new_ui/Views/Ui/auth/boading_screen.dart';

import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginNotifier()),
        ChangeNotifierProvider(create: (context) => Signupprovider()),
        ChangeNotifierProvider(create: (context) => PercentageProvider()),
        ChangeNotifierProvider(create: (context) => PowerButtonProvider()),

        ChangeNotifierProvider(create: (context) => ContainerControllerState()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),

        ChangeNotifierProvider(
          create:
              (context) => SettingsProvider(
                initialColor: Color(0xFF393939),
                clickedColor: Color(kOrange.value),
              ),
        ),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(
          create:
              (context) => TintProvider(
                initialColor: Color(0xFF393939),
                clickedColor: kOrange,
              ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return ScreenUtilInit(
          useInheritedMediaQuery: true,
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Tint Glass',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeProvider.currentTheme,
              home: BoardingScreen(),
            );
          },
        );
      },
    );
  }
}
