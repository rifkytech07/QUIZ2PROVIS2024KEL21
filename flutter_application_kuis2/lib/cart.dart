import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  Map<String, int> items = {};

  void addItem(String foodName) {
    items[foodName] = (items[foodName] ?? 0) + 1;
    notifyListeners();
  }
}
