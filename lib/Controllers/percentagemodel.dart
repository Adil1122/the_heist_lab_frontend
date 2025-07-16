// percentage_model.dart
import 'package:flutter/material.dart';

class PercentageProvider extends ChangeNotifier {
  double _percentage = 0;

  double get percentage => _percentage;

  void setPercentage(double value) {
    _percentage = value.clamp(0, 100);
    notifyListeners();
  }
}
