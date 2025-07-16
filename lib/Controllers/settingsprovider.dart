import 'package:flutter/material.dart';

// Define the options for tint selection
enum tintOption { light, dark, medium }

class SettingsProvider with ChangeNotifier {
  bool _systemErrorAlerts = false;
  bool _successfulTintAlerts = true;
  final Color initialColor;
  final Color clickedColor;
  Color _currentColor;
  // Change to TintOption

  SettingsProvider({required this.initialColor, required this.clickedColor})
    : _currentColor = initialColor;

  Color get currentColor => _currentColor;

  bool get systemErrorAlert => _systemErrorAlerts;
  bool get successfulTintAlert => _successfulTintAlerts;

  tintOption? _selectedOption;
  tintOption? get selectedOption => _selectedOption;

  void selectOption(tintOption option) {
    _selectedOption = option;
    notifyListeners();
  }

  void toggleColor() {
    _currentColor = _currentColor == initialColor ? clickedColor : initialColor;
    notifyListeners();
  }

  void toggleSystemErrorAlert(bool value) {
    _systemErrorAlerts = value;
    notifyListeners();
  }

  void toggleSuccessfulTintAlert(bool value) {
    _successfulTintAlerts = value;
    notifyListeners();
  }
}
