import 'package:flutter/material.dart';

class ContainerControllerState with ChangeNotifier {
  bool _manualMode = false;
  double _sliderValue = 0.5;
  bool _isExpanded = false;

  // ✅ NEW: controls visibility of toggle
  bool _showToggle = true;

  // Getters
  bool get manualMode => _manualMode;
  double get sliderValue => _sliderValue;
  bool get isExpanded => _isExpanded;
  bool get showToggle => _showToggle;

  // Setters & methods
  void toggleManualMode() {
    _manualMode = !_manualMode;
    notifyListeners();
  }

  void setSliderValue(double value) {
    _sliderValue = value.clamp(0.0, 1.0);
    notifyListeners();
  }

  void setManualMode(bool value) {
    _manualMode = value;
    notifyListeners();
  }

  void setExpanded(bool value) {
    _isExpanded = value;
    notifyListeners();
  }

  // ✅ NEW: Show/hide toggle button dynamically
  void setShowToggle(bool value) {
    _showToggle = value;
    notifyListeners();
  }
}
