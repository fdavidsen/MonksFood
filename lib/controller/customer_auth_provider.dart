import 'package:flutter/material.dart';
import 'package:monk_food/model/customer_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:monk_food/model/customer_model.dart';

class CustomerAuthProvider extends ChangeNotifier {
  Customer? _user;

  Customer? get user => _user;

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    if (userId != null) {
      _user = await CustomerHandler().getCustomerById(userId);
      notifyListeners();
    }
  }

  Future<void> setUser(Customer user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', user.id);
    _user = user;
    notifyListeners();
  }

  Future<void> unsetUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    _user = null;
    notifyListeners();
  }
}
