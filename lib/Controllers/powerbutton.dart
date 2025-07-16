import 'package:flutter/material.dart';

class PowerButtonProvider extends ChangeNotifier {
  bool _isOn = false;

  bool get isOn => _isOn;

  void togglePower() {
    _isOn = !_isOn;
    notifyListeners();
  }
}
