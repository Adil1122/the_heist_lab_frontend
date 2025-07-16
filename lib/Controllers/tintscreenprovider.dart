import 'package:flutter/material.dart';

enum TintOption { light, medium, dark }

class TintProvider with ChangeNotifier {
  final Color initialColor;
  final Color clickedColor;
  Color _currentColor;

  TintProvider({required this.initialColor, required this.clickedColor})
    : _currentColor = initialColor;

  Color get currentColor => _currentColor;

  void toggleColor() {
    _currentColor = _currentColor == initialColor ? clickedColor : initialColor;
    notifyListeners();
  }

  TintOption? _selectedOption;

  TintOption? get selectedOption => _selectedOption;

  void selectOption(TintOption option) {
    _selectedOption = option;
    notifyListeners();
  }
}
