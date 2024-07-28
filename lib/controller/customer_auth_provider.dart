import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:monk_food/model/customer_model.dart';

class CustomerAuthProvider extends ChangeNotifier {
  Customer? _user;

  Customer? get user => _user;

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final username = prefs.getString('username');
    final email = prefs.getString('email');
    final phone = prefs.getString('phone');
    final password = prefs.getString('password');

    if (userId != null && username != null && email != null && phone != null && password != null) {
      _user = Customer(
        id: userId,
        username: username,
        email: email,
        phone: phone,
        password: password,
      );
      notifyListeners();
    }
  }

  Future<void> setUser(Customer user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', user.id);
    await prefs.setString('username', user.username);
    await prefs.setString('email', user.email);
    await prefs.setString('phone', user.phone);
    await prefs.setString('password', user.password);
    _user = user;
    notifyListeners();
  }

  Future<void> unsetUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('username');
    await prefs.remove('email');
    await prefs.remove('phone');
    await prefs.remove('password');
    _user = null;
    notifyListeners();
  }
}
