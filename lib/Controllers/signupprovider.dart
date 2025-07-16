import 'package:flutter/material.dart';

class Signupprovider extends ChangeNotifier {
  bool _obsecureText = true;
  bool get obsecureText => _obsecureText;
  set obsecureText(bool newState) {
    _obsecureText = newState;
    notifyListeners();
  }
}
