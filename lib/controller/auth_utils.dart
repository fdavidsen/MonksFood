import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLoginRole(String loggedInAs) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('loggedInAs', loggedInAs);
}

Future<String> getLoginRole() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('loggedInAs') ?? 'none';
}
