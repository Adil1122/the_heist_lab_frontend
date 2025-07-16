import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_ui/Constants/app_constants.dart';
import 'package:new_ui/Views/Ui/Home/home1.dart';
import 'package:new_ui/Views/Ui/Home/location.dart';
import 'package:new_ui/Views/Ui/Home/setting.dart';
import 'package:new_ui/Views/Ui/Home/tint_screen.dart';

// Main page with floating nav bar
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<_NavBarItemData> _navItems = [
    _NavBarItemData(label: 'Home'),
    _NavBarItemData(label: 'Tint'),

    _NavBarItemData(label: 'Location'),
    _NavBarItemData(label: 'Settings'),
  ];

  final List<Widget> _screens = const [
    HomeScreen(),
    TintScreen(),
    LocationScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a Stack to float nav bar above body
      body: Stack(
        children: [
          // Main content
          _screens[_selectedIndex],

          // Floating custom bottom nav bar
          Positioned(
            left: 30.h,
            right: 30.h,
            bottom: 10.h, // adjust to float above bottom
            child: Container(
              height: 40.h,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(color: Color(0xFFE2E2E2)),

                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  _navItems.length,
                  (index) => _FloatingNavBarItem(
                    data: _navItems[index],
                    isSelected: _selectedIndex == index,
                    onTap: () => _onItemTapped(index),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Floating nav bar item widget
class _NavBarItemData {
  final String label;

  const _NavBarItemData({required this.label});
}

class _FloatingNavBarItem extends StatelessWidget {
  final _NavBarItemData data;
  final bool isSelected;
  final VoidCallback onTap;

  const _FloatingNavBarItem({
    Key? key,
    required this.data,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? kOrange : Colors.grey;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                data.label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.normal,
                  fontSize: 12.h,
                ),
              ),
            ],
          ),

          // Dot that overflows below the container
          if (isSelected)
            Positioned(
              bottom: -11.h, // overflow below container
              child: Image.asset(
                'assets/Ellipse1.png',
                width: 15.w,
                height: 10.h,
                fit: BoxFit.contain,
              ),
            ),
        ],
      ),
    );
  }
}
