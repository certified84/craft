import 'package:flutter/material.dart';

class SingleNotifier extends ChangeNotifier {
  late List options;
  String _currentOption = '';
  SingleNotifier(this.options) {
    _currentOption = options[0];
  }
  String get currentOption => options[0];
  updateOption(String value) {
    if (value != _currentOption) {
      _currentOption = value;
      notifyListeners();
    }
  }
}
